'From Cuis 5.0 [latest update: #4024] on 20 February 2020 at 11:52:16 am'!
'Description '!
!provides: 'Arcade-Physics' 1 0!
SystemOrganization addCategory: #'Arcade-Physics'!



!Point methodsFor: '*Arcade-Physics' stamp: 'DF 2/20/2020 11:45:20'!
projectOn: aPoint

	^self dotProduct: aPoint normalized! !
