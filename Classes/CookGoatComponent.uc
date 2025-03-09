class CookGoatComponent extends GGMutatorComponent;

var GGGoat gMe;
var GGMutator myMut;

var StaticMeshComponent hatMesh;

var SoundCue cookSound;
var bool isLickPressed;

/**
 * See super.
 */
function AttachToPlayer( GGGoat goat, optional GGMutator owningMutator )
{
	local ExplosiveCake tmpCake;

	super.AttachToPlayer(goat, owningMutator);

	if(mGoat != none)
	{
		gMe=goat;
		myMut=owningMutator;

		hatMesh.SetLightEnvironment( gMe.mesh.LightEnvironment );
		gMe.mesh.AttachComponentToSocket( hatMesh, 'hairSocket' );
		//First cake fail to explode correctly, so spawn it here and destroy it
		tmpCake = gMe.Spawn( class'ExplosiveCake',,, gMe.Location,,, true);
		tmpCake.ShutDown();
		tmpCake.Destroy();
	}
}

function KeyState( name newKey, EKeyState keyState, PlayerController PCOwner )
{
	local GGPlayerInputGame localInput;

	if(PCOwner != gMe.Controller)
		return;

	localInput = GGPlayerInputGame( PCOwner.PlayerInput );

	if( keyState == KS_Down )
	{
		if( localInput.IsKeyIsPressed( "GBA_Special", string( newKey ) ) )
		{
			if(isLickPressed)
			{
				BakeCake();
			}
		}

		if( localInput.IsKeyIsPressed( "GBA_AbilityBite", string( newKey ) ) )
		{
			isLickPressed=true;
		}
	}
	else if( keyState == KS_Up )
	{
		if( localInput.IsKeyIsPressed( "GBA_AbilityBite", string( newKey ) ) )
		{
			isLickPressed=false;
		}
	}
}

function BakeCake()
{
	local vector spawnLocation;
	local ExplosiveCake expCake;

	gMe.Mesh.GetSocketWorldLocationAndRotation( 'Demonic', spawnLocation );
	if(IsZero(spawnLocation))
	{
		spawnLocation=gMe.Location + (Normal(vector(gMe.Rotation)) * (gMe.GetCollisionRadius() + 30.f));
	}
	gMe.PlaySound(cookSound);
	expCake = gMe.Spawn( class'ExplosiveCake',,, spawnLocation,,, true);
	expCake.CollisionComponent.WakeRigidBody();
}

defaultproperties
{
	Begin Object class=StaticMeshComponent Name=StaticMeshComp1
		StaticMesh=StaticMesh'Food.mesh.Food_Spoon_01'
		Rotation=(Yaw=0,Pitch=0,Roll=32768)
		Translation=(X=0,Y=0,Z=12)
		scale=0.5f
	End Object
	hatMesh=StaticMeshComp1

	cookSound=SoundCue'MMO_IMPACT_SOUND.Cue.IMP_Pumpkin_Cue'
}