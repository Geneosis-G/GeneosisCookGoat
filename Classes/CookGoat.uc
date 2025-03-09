class CookGoat extends GGMutator;

var MaterialInstanceConstant mCreamMat;

/**
 * Called when an actor takes damage
 */
function OnTakeDamage( Actor damagedActor, Actor damageCauser, int damage, class< DamageType > dmgType, vector momentum )
{
	super.OnTakeDamage(damagedActor, damageCauser, damage, dmgType, momentum);

 	if(class< GGDamageTypeCake >(dmgType) != none)
 	{
 		MakeActorCreamy(damagedActor);
 	}
}

function bool IsActorAllowed(Actor targetAct)
{
	return GGPawn(targetAct) != none
	|| GGKactor(targetAct) != none
	|| GGSVehicle(targetAct) != none
	|| GGSVehicle(targetAct) != none
	|| GGInterpActor(targetAct) != none
	|| GGApexDestructibleActor(targetAct) != none;
}

function MakeActorCreamy(Actor targetAct)
{
	local StaticMeshActor targetSMA;
	local DynamicSMActor targetDSMA;
	local ApexDestructibleActor targetADA;
	local Pawn targetPawn;
	local GGKAsset targetKAss;

	if(targetAct == none || !IsActorAllowed(targetAct))
	{
		return;
	}

	targetSMA = StaticMeshActor(targetAct);
	targetDSMA = DynamicSMActor(targetAct);
	targetADA = ApexDestructibleActor(targetAct);
	targetPawn = Pawn(targetAct);
	targetKass = GGKAsset(targetAct);

	if(targetSMA != none)
	{
		MakeCreamy(mCreamMat, targetSMA.StaticMeshComponent);
	}
	else if(targetDSMA != none)
	{
		MakeCreamy(mCreamMat, targetDSMA.StaticMeshComponent);
	}
	else if(targetADA != none)
	{
		MakeCreamy(mCreamMat, targetADA.StaticDestructibleComponent);
	}
	else if(targetPawn != none)
	{
		MakeCreamy(mCreamMat, targetPawn.mesh);
	}
	else if(targetKass != none)
	{
		MakeCreamy(mCreamMat, targetKass.SkeletalMeshComponent);
	}
}

function bool MakeCreamy(MaterialInterface sourceMaterial, MeshComponent targetComp)
{
	local int matIndex;

	if(sourceMaterial == none
	|| targetComp == none
	|| targetComp.Owner == none)
		return false;

	for(matIndex=0 ; matIndex <targetComp.GetNumElements() ; matIndex++)
	{
		targetComp.SetMaterial(matIndex, sourceMaterial);
	}

	return true;
}

DefaultProperties
{
	mMutatorComponentClass=class'CookGoatComponent'

	mCreamMat=MaterialInstanceConstant'Heist_Birthday.Materials.Cream_Mat_01_INST'
}