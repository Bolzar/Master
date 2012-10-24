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

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "PoolMgr.h"
#include "Group.h"
#include "SpellInfo.h"
#include "baradin_hold.h"

enum Spells
{
	spell_Eyes_of_Occuthar = 96920,
	spell_Focused_Fire     = 96884,
	spell_Searing_Shadows  = 96913,
	spell_berserk          = 47008,
};

enum Events
{
	Event_Eyes_of_Occuthar = 1,
	Event_Focused_Fire     = 2,
	Event_Searing_Shadows  = 3,
	Event_Berserk          = 4,
};

class boss_occuthar : public CreatureScript
{
    public:
        boss_occuthar() : CreatureScript("boss_occuthar") { }

        struct boss_occutharAI : public BossAI
        {
            boss_occutharAI(Creature* creature) : BossAI(creature, DATA_OCCUTHAR)
            {
			}

			void reset()
			{
				me->RemoveAurasDueToSpell(spell_berserk);
				events.ScheduleEvent(Event_Eyes_of_Occuthar, 60000);
				events.ScheduleEvent(Event_Focused_Fire, 20000);
				events.ScheduleEvent(Event_Searing_Shadows, 15000);
			}

			void EnterCombat(Unit* /*who*/)
            {
				events.ScheduleEvent(Event_Eyes_of_Occuthar, 60000);
				events.ScheduleEvent(Event_Focused_Fire, 20000);
				events.ScheduleEvent(Event_Searing_Shadows, 15000);
			}

			void UpdateAI(uint32 const diff)
            {
				if (!UpdateVictim() || !CheckInRoom())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
					case Event_Eyes_of_Occuthar:
						DoCast(spell_Eyes_of_Occuthar);
						events.ScheduleEvent(Event_Eyes_of_Occuthar, 60000);
						break;
					case Event_Focused_Fire:
						if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
							DoCast(target, spell_Focused_Fire);
						events.ScheduleEvent(Event_Focused_Fire, 20000);
						break;
					case Event_Searing_Shadows:
						DoCast(spell_Searing_Shadows);
						events.ScheduleEvent(Event_Searing_Shadows, 15000);
						break;
						}
					}
				DoMeleeAttackIfReady();
			}
	};
    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_occutharAI(creature);
    }
};

void AddSC_boss_occuthar()
{
    new boss_occuthar();
}