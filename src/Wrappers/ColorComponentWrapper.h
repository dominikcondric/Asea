#pragma once
#include "Coa/ECS/Components/ColorComponent.h"
#include <QQuickItem>

class ColorComponentWrapper {
    Q_GADGET
    Q_PROPERTY(QColor color READ color WRITE setColor)

public:
    ColorComponentWrapper() = default;
    ColorComponentWrapper(Coa::ColorComponent* colorComponent) : m_colorComponent(colorComponent) {}
    ~ColorComponentWrapper() = default;
    void setColor(const QColor& color)
    {
        m_colorComponent->color.r = color.redF();
        m_colorComponent->color.g = color.greenF();
        m_colorComponent->color.b = color.blueF();
        m_colorComponent->color.a = color.alphaF();
    }

    QColor color() const
    {
        return QColor(
            m_colorComponent->color.r * 255,
            m_colorComponent->color.g * 255,
            m_colorComponent->color.b * 255,
            m_colorComponent->color.a * 255
        );
    }

private:
    Coa::ColorComponent* m_colorComponent = nullptr;
};