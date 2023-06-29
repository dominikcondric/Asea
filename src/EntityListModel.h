#pragma once
#include "Coa/ECS/Entity.h"
#include <QQMLEngine>
#include <QAbstractListModel>
#include "Wrappers/EntityWrapper.h"
#include <queue>
#include "Utility/Commands/Command.h"
#include "Wrappers/SceneWrapper.h"

class EntityListModel : public QAbstractListModel {
    Q_OBJECT
    QML_ELEMENT

public:
    EntityListModel() = default;
    ~EntityListModel() = default;
    int rowCount(const QModelIndex& parent) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE EntityWrapper addEntity(int parentEntityIndex);
    Q_INVOKABLE void removeEntity(int listIndex);
    Q_INVOKABLE EntityWrapper getEntity(int index) { return EntityWrapper(entities.at(index)); }
    Q_INVOKABLE void initializeScene(int viewportWidth, int viewportHeight);
    Q_INVOKABLE SceneWrapper getSceneWrapper() { return SceneWrapper(&m_currentScene, &m_commands); }
    int getEntityListIndex(Coa::EntityID entityID) const;
    
private:
    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    Coa::Scene m_currentScene;
    std::queue<std::unique_ptr<Command>> m_commands;
    uint32_t entitiesCount = 0;
    QList<Coa::Entity> entities;
};