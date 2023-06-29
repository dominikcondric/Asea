#include "LoadMeshCommand.h"
#include "Coa/ECS/Components/MeshComponent.h"

void LoadMeshCommand::execute()
{
    m_entity.getComponent<Coa::MeshComponent>().load(m_model, m_lightened, m_material);
}