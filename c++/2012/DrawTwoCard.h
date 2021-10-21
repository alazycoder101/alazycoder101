/*
 * DrawTwoCard.h
 *
 *  Created on: Feb 5, 2018
 *      Author: kevinw
 */

#ifndef DRAWTWOCARD_H_
#define DRAWTWOCARD_H_

#include "SkipCard.h"

using namespace std;



class DrawTwoCard: public SkipCard
{
public:
	DrawTwoCard(Color);
	virtual ~DrawTwoCard();
	virtual void castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile);
	virtual bool operator^(const Card& t) const;
	virtual void serialize(ostream&) const;
	virtual void init();
};

#endif /* DRAWTWOCARD_H_ */
