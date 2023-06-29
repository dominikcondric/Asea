#pragma once
#include <QQuickItem>
#include "Coa/ECS/Components/SkyboxComponent.h"
#include "EntityWrapper.h"
#include "SceneWrapper.h"
#include "Utility/Commands/LoadSkyboxCommand.h"

class SkyboxComponentWrapper {
    Q_GADGET
    Q_PROPERTY(int blurLevel READ blurLevel WRITE setBlurLevel)

public:
    SkyboxComponentWrapper() = default;
    SkyboxComponentWrapper(Coa::SkyboxComponent* skyboxComponent) : m_skyboxComponent(skyboxComponent) {}
    ~SkyboxComponentWrapper() = default;
    int blurLevel() const { return m_skyboxComponent->blurLevel; }
    void setBlurLevel(int blurLevel) { m_skyboxComponent->blurLevel = blurLevel; }

    Q_INVOKABLE void setTexture(const QList<QString>& skyboxImages, EntityWrapper entity, SceneWrapper sceneWrapper)
    {
        LoadSkyboxCommand* loadSkyboxCommand = new LoadSkyboxCommand(entity.getEntity());
        for (int i = 0; i < loadSkyboxCommand->m_images.size(); ++i)
        {
            if (!skyboxImages[i].isEmpty())
                loadSkyboxCommand->m_images[i].load(skyboxImages[i].toStdString());
        }

        sceneWrapper.m_commands->push(std::unique_ptr<LoadSkyboxCommand>(loadSkyboxCommand));
    }

private:
    Coa::SkyboxComponent* m_skyboxComponent;
};