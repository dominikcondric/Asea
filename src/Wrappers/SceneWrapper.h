#pragma once
#include <QQuickItem>
#include "Coa/ECS/Scene.h"
#include <queue>
#include "Utility/Commands/Command.h"

class SceneWrapper {
    Q_GADGET

public:
    SceneWrapper() = default;
    SceneWrapper(Coa::Scene* scene, std::queue<std::unique_ptr<Command>>* commands) : m_scene(scene), m_commands(commands) {}
    ~SceneWrapper() = default;
    Coa::Scene* m_scene;
    std::queue<std::unique_ptr<Command>>* m_commands;
};