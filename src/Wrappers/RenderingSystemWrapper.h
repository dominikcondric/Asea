#pragma once
#include <QQmlEngine>
#include "Coa/Systems/RenderingSystem.h"
#include <QColor>

class RenderingSystemWrapper {
    Q_GADGET
    Q_PROPERTY(bool shadows READ shadows WRITE setShadows)
    Q_PROPERTY(bool renderHelperGrid READ renderHelperGrid WRITE setRenderHelperGrid)
    Q_PROPERTY(int celShadingLevelsCount READ celShadingLevelsCount WRITE setCelShadingLevelsCount)
    Q_PROPERTY(QColor helperGridColor READ helperGridColor WRITE setHelperGridColor)

public:
    RenderingSystemWrapper() = default;
    RenderingSystemWrapper(Coa::RenderingSystem* renderingSystem) : m_renderingSystem(renderingSystem) {}
    ~RenderingSystemWrapper() = default;
    int celShadingLevelsCount() const 
    {
        if (m_renderingSystem) 
            return m_renderingSystem->getLightRenderer().getCelShadingLevelCount(); 
        
        return 0;
    }

    void setCelShadingLevelsCount(int levelCount) 
    {   
        if (m_renderingSystem)
            m_renderingSystem->getLightRenderer().enableCelShading(levelCount); 
    }

    bool renderHelperGrid() const 
    {
        if (m_renderingSystem)
            return m_renderingSystem->renderHelperGrid;

        return false;
    }
    void setRenderHelperGrid(bool renderHelperGrid) 
    { 
        if (m_renderingSystem)
            m_renderingSystem->renderHelperGrid = renderHelperGrid; 
    }

    void setShadows(bool shadows) 
    { 
        if (m_renderingSystem)
            m_renderingSystem->getLightRenderer().shadows = shadows; 
    }

    bool shadows() const 
    { 
        if (m_renderingSystem)
            return m_renderingSystem->getLightRenderer().shadows; 
        
        return true;
    }

    void setHelperGridColor(QColor color)
    {
        if (!m_renderingSystem)
            return;

        glm::vec4& gridColor = m_renderingSystem->getHelperGridRenderer().gridColor;
        gridColor.r = color.redF();
        gridColor.g = color.greenF();
        gridColor.b = color.blueF();
        gridColor.a = color.alphaF();
    }

    QColor helperGridColor() const
    {
        if (!m_renderingSystem)
            return QColor();

        return QColor::fromRgbF(
            m_renderingSystem->getHelperGridRenderer().gridColor.r,
            m_renderingSystem->getHelperGridRenderer().gridColor.g,
            m_renderingSystem->getHelperGridRenderer().gridColor.b,
            m_renderingSystem->getHelperGridRenderer().gridColor.a
        );
    }

private:
    Coa::RenderingSystem* m_renderingSystem;
};