/** NumberCard.h
 *
 *  Created on: Jan 29, 2018
 *      Author: kevinw
 */

#ifndef NUMBERCARD_H_
#define NUMBERCARD_H_

#include <string>
#include <iostream>

#include "Card.h"

using namespace std;


class NumberCard: public Card
{
public:
	NumberCard(int, Color);
	virtual ~NumberCard();
	virtual bool operator ^(const Card& t) const;
	virtual void serialize(ostream&) const;
	virtual void castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile);
	virtual void init();
};




#endif /* NUMBERCARD_H_ */
