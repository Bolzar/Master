/*
 * Copyright (C) 2008-2012 Holystone Productions>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef Baradin_Hold_H_
#define Baradin_Hold_H_

#include "SpellScript.h"
#include "Map.h"
#include "Creature.h"

#define BHScriptName "instance_Baradin_Hold"

enum SharedSpells
{
	SPELL_BERSERK                       = 26662,
    SPELL_BERSERK2                      = 47008,
};

enum DataTypes
{
	Data_Argaloth = 0,
	Data_Occuthar = 1,
	Data_Alizabal = 2,
};

enum CreaturesIds
{
	Npc_Argaloth = 47120,
	Npc_Occuthar = 52363,
	Npc_Alizabal = 55869,
};

template<class AI>
CreatureAI* GetBaradinHoldAI(Creature* creature)
{
    if (InstanceMap* instance = creature->GetMap()->ToInstanceMap())
        if (instance->GetInstanceScript())
            if (instance->GetScriptId() == sObjectMgr->GetScriptId(BHScriptName))
                return new AI(creature);
    return NULL;
}

#endif