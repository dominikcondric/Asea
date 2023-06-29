#pragma once
#include "Coa/ECS/Components/TextureComponent.h"
#include <QQuickItem>
#include "Utility/Commands/LoadTextureCommand.h"
#include "EntityWrapper.h"
#include "SceneWrapper.h"

class TextureComponentWrapper {
    Q_GADGET
    Q_PROPERTY(QString diffuseMapPath READ diffuseMapPath)
    Q_PROPERTY(QString specularMapPath READ specularMapPath)
    Q_PROPERTY(QString normalMapPath READ normalMapPath)

public:
    TextureComponentWrapper() = default;
    TextureComponentWrapper(Coa::TextureComponent* textureComponent) : m_textureComponent(textureComponent) {}
    ~TextureComponentWrapper() = default;
    
    QString diffuseMapPath() const
    {
       return QString::fromStdString(m_textureComponent->diffuseMapPath);
    }

    QString specularMapPath() const
    {
       return QString::fromStdString(m_textureComponent->specularMapPath);
    }

    QString normalMapPath() const
    {
       return QString::fromStdString(m_textureComponent->normalMapPath);
    }

    Q_INVOKABLE void setDiffuseMap(const QString& diffuseMapPath, EntityWrapper entity, SceneWrapper sceneWrapper)
    {
        LoadTextureCommand* loadTextureCommand = new LoadTextureCommand(entity.getEntity(), LoadTextureCommand::Map::Diffuse);
        
        if (!diffuseMapPath.isEmpty())
        {
            loadTextureCommand->m_image.load(diffuseMapPath.toStdString());
            entity.getEntity().getComponent<Coa::TextureComponent>().diffuseMapPath = diffuseMapPath.toStdString();
        }
        else 
        {
            entity.getEntity().getComponent<Coa::TextureComponent>().diffuseMapPath.clear();
        }

        sceneWrapper.m_commands->push(std::unique_ptr<LoadTextureCommand>(loadTextureCommand));
    }

private:
    Coa::TextureComponent* m_textureComponent;
};