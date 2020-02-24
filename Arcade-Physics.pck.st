'From Cuis 5.0 [latest update: #4024] on 23 February 2020 at 9:41:40 pm'!
'Description Simple two dimensional physics simulation'!
!provides: 'Arcade-Physics' 1 4!
SystemOrganization addCategory: #'Arcade-Physics'!


!classDefinition: #Particle category: #'Arcade-Physics'!
Object subclass: #Particle
	instanceVariableNames: 'direction speed birth lifespan alive position velocity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Arcade-Physics'!
!classDefinition: 'Particle class' category: #'Arcade-Physics'!
Particle class
	instanceVariableNames: ''!

!classDefinition: #ParticleSystem category: #'Arcade-Physics'!
Object subclass: #ParticleSystem
	instanceVariableNames: 'particles'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Arcade-Physics'!
!classDefinition: 'ParticleSystem class' category: #'Arcade-Physics'!
ParticleSystem class
	instanceVariableNames: ''!

!classDefinition: #FPSMorph category: #'Arcade-Physics'!
BorderedRectMorph subclass: #FPSMorph
	instanceVariableNames: 'frames start fps'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Arcade-Physics'!
!classDefinition: 'FPSMorph class' category: #'Arcade-Physics'!
FPSMorph class
	instanceVariableNames: ''!

!classDefinition: #ParticleSystemMorph category: #'Arcade-Physics'!
BorderedRectMorph subclass: #ParticleSystemMorph
	instanceVariableNames: 'particleSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Arcade-Physics'!
!classDefinition: 'ParticleSystemMorph class' category: #'Arcade-Physics'!
ParticleSystemMorph class
	instanceVariableNames: ''!


!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:01:11'!
alive
	^alive! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 16:59:00'!
birth: aNumber
	birth := aNumber
! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 16:59:11'!
born 
	^ birth <= 0! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:00:03'!
direction: aNumber

	direction := aNumber
! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:00:11'!
initialize
	
	speed := 0.
	birth := 0.
	alive := true
! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:01:26'!
lifespan
	^lifespan! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:01:33'!
lifespan: aNumber
	lifespan := aNumber! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:01:03'!
noise

	^(2 atRandom - 1) @ (2 atRandom - 1)

! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:01:18'!
position
	^position! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:01:40'!
position: aPoint
	position := aPoint! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:00:19'!
speed: aNumber

	speed := aNumber! !

!Particle methodsFor: 'as yet unclassified' stamp: 'DF 2/20/2020 17:00:38'!
stepFor: dt
	
	(birth > 0) ifTrue:[
		birth := birth - dt.
		^self ].
	
	(lifespan <= 0) ifTrue:[
		alive := false.
		^self ].
	
	lifespan := lifespan - dt.
	
	velocity := Point r: speed degrees: direction.
	 
	position := position + (velocity * dt) + (self noise).
! !

!ParticleSystem methodsFor: 'accessing' stamp: 'DavidFaitelson 1/25/2020 23:46'!
explosionAt: aPoint| d |d := 0.12 timesRepeat:[		| aParticle |		aParticle := Particle new.		aParticle position: aPoint.		aParticle direction: d.		aParticle lifespan: 0.9.		aParticle speed: 40.		d := d + (360 / 12).		self addParticle: aParticle.].! !

!ParticleSystem methodsFor: 'accessing' stamp: 'DavidFaitelson 1/24/2020 20:48'!
extent	^800 @ 600! !

!ParticleSystem methodsFor: 'accessing' stamp: 'DavidFaitelson 1/25/2020 23:32'!
jetAt: aPoint direction: aNumber| d  | d := 0.5 timesRepeat:[		| aParticle |		aParticle := Particle new.		aParticle position: aPoint.		aParticle direction: aNumber.		aParticle birth: d.		d := d + 0.1.		aParticle lifespan: 0.3.		aParticle speed: 20.		self addParticle: aParticle.].! !

!ParticleSystem methodsFor: 'accessing' stamp: 'DavidFaitelson 1/24/2020 22:04'!
stepFor: dt	particles := particles select:[:each | each alive ].		particles do:[:each | each stepFor: dt]! !

!ParticleSystem methodsFor: 'enumerating' stamp: 'DF 2/20/2020 16:54:20'!
do: aBlock
	particles select:[:each | each born] thenDo: aBlock! !

!ParticleSystem methodsFor: 'initialization' stamp: 'DavidFaitelson 1/24/2020 20:47'!
initialize 	particles := OrderedCollection new.! !

!ParticleSystem methodsFor: 'adding' stamp: 'DavidFaitelson 1/24/2020 21:16'!
addParticle: aParticle		particles add: aParticle! !

!FPSMorph methodsFor: 'as yet unclassified' stamp: 'DF 2/22/2020 22:45:55'!
drawOn: aCanvas
	
	super drawOn: aCanvas.
	
	Time now second > start ifTrue:[fps _ 1.0 * frames / (Time now second - start)].
	
	aCanvas drawString: fps asString at: 20@20 font: nil color: Color black.
	
	frames _ frames + 1.
! !

!FPSMorph methodsFor: 'as yet unclassified' stamp: 'DF 2/22/2020 22:49:54'!
startStepping

	super startStepping.
	
	frames _ 0.
	
	fps _ 0.0.
	
	start _ Time now second.! !

!FPSMorph methodsFor: 'as yet unclassified' stamp: 'DF 2/22/2020 22:45:05'!
step
	self redrawNeeded! !

!FPSMorph methodsFor: 'as yet unclassified' stamp: 'DF 2/22/2020 22:51:03'!
stepTime
	^25! !

!FPSMorph methodsFor: 'initialization' stamp: 'DF 2/22/2020 22:44:49'!
initialize

	super initialize.
	
	frames _ 0.
	
	fps _ 0.0.
	
	start _ Time now second.! !

!ParticleSystemMorph methodsFor: 'drawing' stamp: 'DF 2/20/2020 17:08:04'!
drawOn: aCanvas

	| aPen |
	
	super drawOn: aCanvas.
	
	aPen := Pen onCanvas: aCanvas.
	
	aPen down.
	
	particleSystem do:[:each | aPen goto: each position; dot ]! !

!ParticleSystemMorph methodsFor: 'stepping and presenter' stamp: 'DF 2/20/2020 17:14:02'!
step

	particleSystem stepFor: self stepTime / 1000.0.
	
	self redrawNeeded! !

!ParticleSystemMorph methodsFor: 'model - stepping' stamp: 'DF 2/20/2020 17:11:45'!
stepTime
	^100! !

!ParticleSystemMorph methodsFor: 'as yet unclassified' stamp: 'DavidFaitelson 1/24/2020 21:06'!
particleSystem: aParticleSystem	particleSystem := aParticleSystem ! !
