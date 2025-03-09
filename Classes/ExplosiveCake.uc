class ExplosiveCake extends GGExplosiveActorContent
placeable;

var SoundCue mExplosionSound;
var ParticleSystem mExplosionEffectTemplate;
var GGPhysicalMaterialProperty mCakePhysMatProp;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	GetKActorPhysMaterial().PhysicalMaterialProperty=mCakePhysMatProp;
}

DefaultProperties
{
	bStatic=false
	bNoDelete=false

	Begin Object class=GGPhysicalMaterialProperty Name=customPhysMatProp
		mScore=100
		mActorInGameName="Cake"
		mExplosionDecalMat=MaterialInstanceTimeVarying'CookGoatMaterials.Decals_Cream_TimeVarying'
		mDecalSize=(X=557.812500, Y=557.812500, Z=657.812500)
		mExplosionSound=SoundCue'Heist_Audio.Cue.SFX_Dynamite_Explode_Cake_Mono_Cue'
		mExplosionDamage=0
		mExplosionDamageRadius=500
		mExplosiveMomentum=1
	End Object
	mCakePhysMatProp=customPhysMatProp

	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'BeachWedding.Meshes.Cake_01'
	End Object

	mDamageType=class'GGDamageTypeCake'
	mDamage=0
	mDamageRadius=500
	mExplosiveMomentum=1
}