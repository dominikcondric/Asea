#include "EntityListModel.h"
#include <QHash>
#include "Utility/Commands/LoadMeshCommand.h"
#include "Utility/Commands/LoadTextureCommand.h"
#include "Utility/Commands/LoadScriptCommand.h"
#include "Coa/ECS/Components/TagComponent.h"
#include "Coa/ECS/Components/TransformComponent.h"
#include "Coa/ECS/Components/MeshComponent.h"
#include "Coa/ECS/Components/LightComponent.h"
#include "Coa/ECS/Components/CameraComponent.h"
#include "Coa/ECS/Components/ScriptComponent.h"

int EntityListModel::rowCount(const QModelIndex &parent) const
{
    return entities.count();
}

QVariant EntityListModel::data(const QModelIndex &index, int role) const
{
    QVariant data;
    const Coa::Entity& entity = entities.at(index.row());
    switch (role)
    {
        case Qt::DisplayRole:
            data = QString::fromStdString(entity.getComponent<Coa::TagComponent>().name);
            break;
        case Qt::UserRole:
            data = QVariant::fromValue<EntityWrapper>(EntityWrapper(entity));
            break;
    }
    
    return data;
}

QHash<int, QByteArray> EntityListModel::roleNames() const
{
    return QHash<int, QByteArray>({ { Qt::DisplayRole, "name" }, { Qt::UserRole, "entity" } });    
}

EntityWrapper EntityListModel::addEntity(int parentEntityIndex)
{
    Coa::Entity entityToAdd(nullptr, -1);
    if (parentEntityIndex == -1)
    {
        entityToAdd = m_currentScene.addEntity();
        entities.prepend(entityToAdd);
        insertRows(0, 0);
    }
    else
    {
        entityToAdd = m_currentScene.addEntity("", entities.at(parentEntityIndex).getEntityID());
        for (int i = 0; i < entities.size(); ++i)
        {
            if (entities.at(i) == entityToAdd.getParent())
            {
                entities.insert(i+1, entityToAdd);
                insertRows(i+1, 0);
                break;
            }
        }
    }

    return EntityWrapper(entityToAdd);
}

void EntityListModel::removeEntity(int listIndex)
{
    Coa::Entity entityToRemove = entities.at(listIndex);
    int childCount = entityToRemove.getChildren().size();
    m_currentScene.removeEntity(entityToRemove.getEntityID());
    removeRows(listIndex, childCount+1);
}

void EntityListModel::initializeScene(int viewportWidth, int viewportHeight)
{
    beginResetModel();
    entities.clear();
    m_currentScene.clearEntities();

    Coa::SharedLibrary sharedLibrary(std::filesystem::path(OUTPUT_DIR) / "libSceneEditorScripts.dll");

    Coa::Entity cameraEntity = m_currentScene.addEntity("camera");
    Cala::Camera& cam = cameraEntity.addComponent<Coa::CameraComponent>(Cala::Camera::Type::Perspective).camera;
    cam.setProjectionAspectRatio((float)viewportWidth / viewportHeight);
    cam.setProjectionNearPlane(1.f);
    cam.setProjectionFarPlane(100.f);
    cam.setProjectionViewingAngle(45.f);
    cam.setPosition(glm::vec3(0.f, 20.f, 20.f));
    cameraEntity.addComponent<Coa::ScriptComponent>();
    LoadScriptCommand* cameraEntityLoadScriptCommand = new LoadScriptCommand(cameraEntity, sharedLibrary, "CameraMovementScript");
    m_commands.push(std::unique_ptr<LoadScriptCommand>(cameraEntityLoadScriptCommand));

    Coa::Entity lightEntity = m_currentScene.addEntity("light");
    Coa::MeshComponent& lightMeshComponent = lightEntity.addComponent<Coa::MeshComponent>();
    LoadMeshCommand* lightEntityLoadMeshCommand = new LoadMeshCommand(lightEntity, Cala::Model().loadSphere(5, 10), false);
    lightEntity.addComponent<Coa::LightComponent>();
    m_commands.push(std::unique_ptr<LoadMeshCommand>(lightEntityLoadMeshCommand));
    lightEntity.getComponent<Coa::TransformComponent>().transformation.translate(glm::vec3(0.f, 4.f, 0.f)).scale(0.2f);

    entitiesCount = m_currentScene.getEntities().size();
    entities.append(cameraEntity);
    entities.append(lightEntity);
    endResetModel();
}

int EntityListModel::getEntityListIndex(Coa::EntityID entityID) const
{
    for (int i = 0; i < entities.size(); ++i)
    {
        if (entities[i].getEntityID() == entityID)
            return i;
    }
}

bool EntityListModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(QModelIndex(), row, row+count-1);
    entities.remove(row, count);
    endRemoveRows();
    return true;
}

bool EntityListModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row+count);
    endInsertRows();
    return true;
}