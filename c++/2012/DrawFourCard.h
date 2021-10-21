/*
 * DrawFourCard.h
 *
 *  Created on: Feb 6, 2018
 *      Author: kevinw
 */

#ifndef DRAWFOURCARD_H_
#define DRAWFOURCARD_H_

#include "WildCard.h"

using namespace std;



class DrawFourCard: public WildCard
{
public:
	DrawFourCard();
	virtual ~DrawFourCard();
	virtual void castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile);
	virtual void serialize(ostream&) const;
	virtual void init();
	virtual bool operator^(const Card& t) const;
	};
#endif /* DRAWFOURCARD_H_ */
