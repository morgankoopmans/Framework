if (!global.inputGate.CanRead(INPUT_CONTEXT.UI))
{
    exit;
}

if(!CanFocus())
{
    exit;
}

RequestFocus();
Activate();