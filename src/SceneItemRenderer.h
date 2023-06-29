#pragma once
#include <QQuickFramebufferObject>
#include <QOpenGLExtraFunctions>
#include "CopyRenderer.h"
#include "Coa/Systems/Engine.h"
#include "Coa/ECS/Scene.h"
#include <queue>
#include "Utility/Commands/Command.h"
#include "Coa/Systems/RenderingSystem.h"
#include "Coa/Systems/ScriptingSystem.h"

class SceneItemRenderer : public QQuickFramebufferObject::Renderer, private QOpenGLExtraFunctions {
public:
    SceneItemRenderer();
    ~SceneItemRenderer() override;
    QOpenGLFramebufferObject *createFramebufferObject(const QSize &size) override;
    void render() override;
    void synchronize(QQuickFramebufferObject* item) override;

private:
    std::unique_ptr<Cala::GraphicsAPI> m_api;
    std::unique_ptr<Coa::Engine> m_engine;
    std::unique_ptr<CopyRenderer> m_copyRenderer;
    std::unique_ptr<Coa::RenderingSystem> m_renderingSystem = nullptr;
    std::unique_ptr<Coa::ScriptingSystem> m_scriptingSystem = nullptr;
    Cala::Framebuffer framebuffer;
    Coa::Scene* m_currentScene = nullptr;
    std::queue<std::unique_ptr<Command>>* m_commands;
};