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
#include "baradin_hold.h"
#include "SpellInfo.h"

enum Spells
{
	Spell_Meteor_Slash       = 88942,
	Spell_Consuming_Darkness = 88954,
	Spell_Fel_Firestorm      = 88972,
};

enum Events
{
	Event_Meteor_Slash       = 1,
	Event_Comsuming_Darkness = 2,
	Event_Fel_Firestorm      = 3,
	Event_Berserk            = 4,
};

class boss_argaloth : public CreatureScript
{
    public:
        boss_argaloth() : CreatureScript("boss_argaloth") { }

        struct boss_argalothAI : public BossAI
        {
            boss_argalothAI(Creature* creature) : BossAI(creature, Data_Argaloth)
            {
			}

			uint32 fel_firestorm_casted;

			void Reset()
            {
				_Reset();
				me->RemoveAurasDueToSpell(Spell_Fel_Firestorm);
				me->RemoveAurasDueToSpell(SPELL_BERSERK2);
				fel_firestorm_casted = 0;
			}

			void EnterCombat(Unit* /*who*/)
            {
                me->setActive(true);
                DoZoneInCombat();

				events.Reset();
				events.ScheduleEvent(Event_Meteor_Slash, 18000);
				events.ScheduleEvent(Event_Comsuming_Darkness, 20000);
				events.ScheduleEvent(Event_Berserk, 300000);
			}

			void UpdateAI(const uint32 diff)
			{
				if (!UpdateVictim())
					return;

				if (me->GetHealthPct() < 66 && fel_firestorm_casted == 0)
				{
					DoCast(Spell_Fel_Firestorm);
					events.DelayEvents(3000);
					fel_firestorm_casted = 1;
				}

				if (me->GetHealthPct() < 33 && fel_firestorm_casted == 1)
				{
					DoCast(Spell_Fel_Firestorm);
					events.DelayEvents(3000);
					fel_firestorm_casted = 2;
				}

				events.Update(diff);

				while (uint32 eventId = events.ExecuteEvent())
				{
					switch (eventId)
					{
					case Event_Meteor_Slash:
						DoCast(Spell_Meteor_Slash);
						events.ScheduleEvent(Event_Meteor_Slash, 18000);
						break;
					case Event_Comsuming_Darkness:
						if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
							DoCast(target, Spell_Consuming_Darkness);
						events.ScheduleEvent(Event_Comsuming_Darkness, 20000);
						break;
					case Event_Berserk:
						DoCast(SPELL_BERSERK2);
						break;
						}
					}
				DoMeleeAttackIfReady();
			}
	};

CreatureAI* GetAI(Creature* creature) const
        {
            return GetBaradinHoldAI<boss_argalothAI>(creature);
        }
};

void AddSC_boss_argaloth()
{
    new boss_argaloth();
}