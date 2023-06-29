#pragma once
#include <QQuickFramebufferObject>
#include <glm/vec2.hpp>
#include "Coa/ECS/Scene.h"
#include "Coa/Systems/Engine.h"
#include "Utility/Commands/Command.h"
#include <unordered_set>
#include "Wrappers/SceneWrapper.h"
#include "Cala/Utility/IIOSystem.h"
#include "Wrappers/RenderingSystemWrapper.h"

class SceneItemRenderer;

class SceneItem : public QQuickFramebufferObject, public Cala::IIOSystem {
    Q_OBJECT
    QML_ELEMENT

public:
    explicit SceneItem(QQuickItem* parent = nullptr);
    ~SceneItem() = default;
    Renderer* createRenderer() const override;
    Q_INVOKABLE void onResize(uint32_t width, uint32_t height);
    Q_INVOKABLE void updateScene(float deltaTime);
    Q_INVOKABLE void setScene(SceneWrapper sceneWrapper);
    Q_INVOKABLE QVariant getRenderingSystem();
    void setRenderingSystem(Coa::RenderingSystem* renderingSystem) { m_renderingSystem = renderingSystem; }
    std::queue<std::unique_ptr<Command>>* getCommandQueue() const { return m_commands; }
    Coa::Scene* getCurrentScene() const { return m_currentScene; }
    float getDeltaTime() const { return m_deltaTime; }

protected:
    void mousePressEvent(QMouseEvent* event) override;
    void mouseReleaseEvent(QMouseEvent* event) override;
    void hoverMoveEvent(QHoverEvent* event) override;
    void mouseMoveEvent(QMouseEvent* event) override;
    void keyPressEvent(QKeyEvent* event) override;
    void keyReleaseEvent(QKeyEvent* event) override;

private:
    Coa::Scene* m_currentScene = nullptr;
    Coa::RenderingSystem* m_renderingSystem = nullptr;
    std::queue<std::unique_ptr<Command>>* m_commands;

// IOSystem part
private:
    bool apiIsMouseButtonPressed(Cala::IIOSystem::KeyCode code) const override;
    bool apiIsKeyPressed(Cala::IIOSystem::KeyCode code) const override;
    glm::vec2 apiGetCursorPosition() const override;
    std::unordered_set<int> pressedKeys;
    glm::vec2 cursorPosition;
    constexpr int mapKeyToQtCode(Cala::IIOSystem::KeyCode code) const;
    float m_deltaTime;

    const int qtKeys[100] {
        Qt::MouseButton::LeftButton,
        Qt::MouseButton::RightButton,
        Qt::MouseButton::MiddleButton,
        Qt::Key_A, Qt::Key_B, Qt::Key_C, Qt::Key_D, Qt::Key_E, Qt::Key_F,
        Qt::Key_G, Qt::Key_H, Qt::Key_I, Qt::Key_J, Qt::Key_K, Qt::Key_L,
        Qt::Key_M, Qt::Key_N, Qt::Key_O, Qt::Key_P, Qt::Key_Q, Qt::Key_R,
        Qt::Key_S, Qt::Key_T, Qt::Key_U, Qt::Key_V, Qt::Key_W, Qt::Key_X,
        Qt::Key_Y, Qt::Key_Z,
        Qt::Key_Space, Qt::Key_Apostrophe, Qt::Key_Comma, Qt::Key_hyphen,
        Qt::Key_Period, Qt::Key_Slash, Qt::Key_0, Qt::Key_1, Qt::Key_2,
        Qt::Key_3, Qt::Key_4, Qt::Key_5, Qt::Key_6, Qt::Key_7, Qt::Key_8,
        Qt::Key_9, 
        Qt::Key_Escape, Qt::Key_Enter, Qt::Key_Tab, Qt::Key_Backspace, 
        Qt::Key_Insert, Qt::Key_Delete, Qt::Key_Right, Qt::Key_Left,
        Qt::Key_Down, Qt::Key_Up, Qt::Key_PageUp, Qt::Key_PageDown,
        Qt::Key_Home, Qt::Key_End, Qt::Key_CapsLock, Qt::Key_ScrollLock,
        Qt::Key_NumLock, Qt::Key_Print, Qt::Key_Pause, Qt::Key_F1, Qt::Key_F2,
        Qt::Key_F3, Qt::Key_F4, Qt::Key_F4, Qt::Key_F5, Qt::Key_F6, Qt::Key_F7,
        Qt::Key_F8, Qt::Key_F9, Qt::Key_F10, Qt::Key_F11, Qt::Key_F12, 
        Qt::Key_Launch0, Qt::Key_Launch1, Qt::Key_Launch2, Qt::Key_Launch3,
        Qt::Key_Launch4, Qt::Key_Launch5, Qt::Key_Launch6, Qt::Key_Launch7, 
        Qt::Key_Launch8, Qt::Key_Launch9, -1, Qt::Key_division, Qt::Key_multiply,
        Qt::Key_Minus, Qt::Key_Plus, Qt::Key_Enter, Qt::Key_Shift, Qt::Key_Control, -1, -1, -1, -1
    };
};