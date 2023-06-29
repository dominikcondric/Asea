#pragma once
#include <QQuickItem>
#include "Coa/ECS/Components/MeshComponent.h"
#include "EntityWrapper.h"
#include "Utility/Commands/LoadMeshCommand.h"
#include "Cala/Utility/ModelLoader.h"
#include "Coa/ECS/Components/TagComponent.h"
#include "EntityListModel.h"

class MeshComponentWrapper {
    Q_GADGET
    Q_PROPERTY(bool lightened READ lightened WRITE setLightened)
    Q_PROPERTY(QString modelPath READ modelPath)
    Q_PROPERTY(QString modelName READ modelName)
    Q_PROPERTY(bool loaded READ loaded)

public:
    MeshComponentWrapper() = default;
    MeshComponentWrapper(Coa::MeshComponent* meshComponent) : m_meshComponent(meshComponent) {}
    ~MeshComponentWrapper() = default;
    QString modelPath() const { return QString::fromStdString(m_meshComponent->getModelPath()); }
    QString modelName() const { return QString::fromStdString(m_meshComponent->getModelName()); }
    bool loaded() const { return m_meshComponent->mesh.isLoaded(); }
    bool lightened() const { return m_meshComponent->lightened; }
    void setLightened(bool lightened)
    {
        m_meshComponent->lightened = lightened;
    }

    Q_INVOKABLE void freeModel()
    {
        m_meshComponent->mesh.free();
    }

    Q_INVOKABLE void setModel(const QString& modelPath, EntityWrapper entity, EntityListModel* entityListModel)
    {
        if (modelPath == "Cube") 
        {
            LoadMeshCommand* loadMeshCommand = new LoadMeshCommand(entity.getEntity(), Cala::Model().loadCube());
            entityListModel->getSceneWrapper().m_commands->push(std::unique_ptr<LoadMeshCommand>(loadMeshCommand));
        } 
        else if (modelPath == "Sphere") 
        {
            LoadMeshCommand* loadMeshCommand = new LoadMeshCommand(entity.getEntity(), Cala::Model().loadSphere());
            entityListModel->getSceneWrapper().m_commands->push(std::unique_ptr<LoadMeshCommand>(loadMeshCommand));
        }
        else if (modelPath == "Plane") 
        {
            LoadMeshCommand* loadMeshCommand = new LoadMeshCommand(entity.getEntity(), Cala::Model().loadPlane());
            entityListModel->getSceneWrapper().m_commands->push(std::unique_ptr<LoadMeshCommand>(loadMeshCommand));
        }
        else if (modelPath == "Ray") 
        {
            LoadMeshCommand* loadMeshCommand = new LoadMeshCommand(entity.getEntity(), Cala::Model().loadRay());
            entityListModel->getSceneWrapper().m_commands->push(std::unique_ptr<LoadMeshCommand>(loadMeshCommand));
        }
        else
        {
            Cala::ModelLoader modelLoader(true);
            modelLoader.loadFromObj(modelPath.toStdString());
            LoadMeshCommand* loadMeshCommand = new LoadMeshCommand(entity.getEntity(), modelLoader.getModels()[0]);
            entityListModel->getSceneWrapper().m_commands->push(std::unique_ptr<LoadMeshCommand>(loadMeshCommand));

            if (modelLoader.getModels().size() > 1)
            {
                for (uint32_t i = 1; i < modelLoader.getModels().size(); ++i)
                {
                    const Cala::Model& model = modelLoader.getModels()[i];
                    Coa::Entity childEntity = entityListModel->addEntity(entityListModel->getEntityListIndex(entity.getEntity().getEntityID())).getEntity();
                    Coa::MeshComponent& meshComponent = childEntity.addComponent<Coa::MeshComponent>();
                    LoadMeshCommand* loadMeshCommand = new LoadMeshCommand(childEntity, model);
                    entityListModel->getSceneWrapper().m_commands->push(std::unique_ptr<LoadMeshCommand>(loadMeshCommand));
                }
            }
        }
    }

private:
    Coa::MeshComponent* m_meshComponent;
};