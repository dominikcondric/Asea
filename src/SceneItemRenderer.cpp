#include "SceneItemRenderer.h"
#include <QOpenGLFramebufferObjectFormat>
#include <QQuickWindow>
#include <QQuickOpenGLUtils>
#include "SceneItem.h"
#include "Cala/Rendering/GraphicsAPI.h"
#include "Utility/Commands/LoadMeshCommand.h"

SceneItemRenderer::SceneItemRenderer() : m_api(Cala::GraphicsAPI::construct())
{
    initializeOpenGLFunctions();
    Cala::GraphicsAPI::loadAPIFunctions();
    m_engine.reset(new Coa::Engine);
    m_copyRenderer.reset(new CopyRenderer);

    m_renderingSystem.reset(new Coa::RenderingSystem(m_api.get(), &framebuffer));

    m_engine->addSystem(m_renderingSystem.get());

    Cala::Texture::Specification colorTargetSpecification(
        2048, 2048, 
        Cala::ITexture::Format::RGBA, Cala::ITexture::Dimensionality::TwoDimensional
    );

    Cala::Texture* colorTarget = new Cala::Texture;
    colorTarget->load(colorTargetSpecification, nullptr);

    framebuffer.addColorTarget(colorTarget, true);

    Cala::Texture::Specification depthTargetSpecification(
        2048, 2048, 
        Cala::ITexture::Format::DEPTH24_STENCIL8, Cala::ITexture::Dimensionality::TwoDimensional
    );

    Cala::Texture* depthTarget = new Cala::Texture;
    depthTarget->load(depthTargetSpecification, nullptr);
    framebuffer.addDepthTarget(depthTarget, true);

    framebuffer.load();
}

SceneItemRenderer::~SceneItemRenderer()
{
}

QOpenGLFramebufferObject* SceneItemRenderer::createFramebufferObject(const QSize &size)
{
    QOpenGLFramebufferObjectFormat format;
    format.setSamples(4);
    format.setAttachment(QOpenGLFramebufferObject::NoAttachment);
    return new QOpenGLFramebufferObject(2048, 2048, format);
}

void SceneItemRenderer::render()
{
    bool shouldUpdateList = false;
    while (!m_commands->empty())
    {
        auto& command = m_commands->front();
        command->execute();
        m_commands->pop();
    }

    m_api->activateFramebuffer(&framebuffer);
    m_api->clearFramebuffer();
    m_engine->run(*m_currentScene);
    m_copyRenderer->render(m_api.get(), framebufferObject(), &framebuffer);

    glBindVertexArray(0);
    QQuickOpenGLUtils::resetOpenGLState();
}

void SceneItemRenderer::synchronize(QQuickFramebufferObject *item)
{
    SceneItem* sceneItem = static_cast<SceneItem*>(item);
    sceneItem->setRenderingSystem(m_renderingSystem.get());

    if (m_scriptingSystem == nullptr)
    {
        m_scriptingSystem.reset(new Coa::ScriptingSystem(*sceneItem));
        m_engine->addSystem(m_scriptingSystem.get());
    }

    m_currentScene = sceneItem->getCurrentScene();
    m_commands = sceneItem->getCommandQueue();
    m_scriptingSystem->setDeltaTime(sceneItem->getDeltaTime());
}