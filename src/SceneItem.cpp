#include "SceneItem.h"
#include "SceneItemRenderer.h"
#include "Coa/ECS/Components/CameraComponent.h"

SceneItem::SceneItem(QQuickItem *parent) : QQuickFramebufferObject(parent)
{
    setAcceptedMouseButtons(Qt::AllButtons);
    setMirrorVertically(true);
    setAcceptHoverEvents(true);
}

QQuickFramebufferObject::Renderer *SceneItem::createRenderer() const
{
    return new SceneItemRenderer;
}

void SceneItem::onResize(uint32_t width, uint32_t height)
{
    if (!m_currentScene)
        return;

    for (Coa::EntityID e : m_currentScene->getComponentEntityList<Coa::CameraComponent>())
    {
        Coa::CameraComponent& camComp = m_currentScene->getComponent<Coa::CameraComponent>(e);
        if (camComp.isMain)
        {
            camComp.camera.setProjectionAspectRatio((float)width / height);
            break;
        }
    }
}

void SceneItem::updateScene(float deltaTime)
{
    QQuickFramebufferObject::update();
    Cala::IIOSystem::update();
    m_deltaTime = deltaTime; 
}

void SceneItem::setScene(SceneWrapper sceneWrapper)
{
    m_currentScene = sceneWrapper.m_scene;
    m_commands = sceneWrapper.m_commands;
}

QVariant SceneItem::getRenderingSystem()
{
    return QVariant::fromValue<RenderingSystemWrapper>(RenderingSystemWrapper(m_renderingSystem));
}

void SceneItem::mousePressEvent(QMouseEvent *event)
{
    pressedKeys.insert(event->button());

    if (event->button() == Qt::LeftButton) 
        setFocus(true);

    event->accept();
}

void SceneItem::mouseReleaseEvent(QMouseEvent *event)
{
    pressedKeys.erase(event->button());
    event->accept();
}

void SceneItem::hoverMoveEvent(QHoverEvent *event)
{
    auto cursorPos = event->globalPosition();
    cursorPosition.x = cursorPos.x();
    cursorPosition.y = cursorPos.y();

    event->accept();
}

void SceneItem::mouseMoveEvent(QMouseEvent *event)
{
    auto cursorPos = event->globalPosition();
    cursorPosition.x = cursorPos.x();
    cursorPosition.y = cursorPos.y();

    event->accept();
}

void SceneItem::keyPressEvent(QKeyEvent *event)
{
    pressedKeys.insert(event->key());
    event->accept();
}

void SceneItem::keyReleaseEvent(QKeyEvent *event)
{
    pressedKeys.erase(event->key());
    event->accept();
}

bool SceneItem::apiIsMouseButtonPressed(Cala::IIOSystem::KeyCode code) const
{
    return pressedKeys.find(mapKeyToQtCode(code)) != pressedKeys.end();
}

bool SceneItem::apiIsKeyPressed(Cala::IIOSystem::KeyCode code) const
{
    return apiIsMouseButtonPressed(code);
}

glm::vec2 SceneItem::apiGetCursorPosition() const
{
    return cursorPosition;
}

constexpr int SceneItem::mapKeyToQtCode(Cala::IIOSystem::KeyCode code) const
{
    return qtKeys[code];
}