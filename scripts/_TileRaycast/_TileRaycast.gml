
/// @func TileRaycast(_x0, _y0, _x1, _y1, _tm)
/// @desc DDA raycast through tilemap.
///       Returns:
///       { hit: true, x, y, nx, ny, dist, tileX, tileY }
///       or { hit: false }

function TileRaycast(_x0, _y0, _x1, _y1, _tm)
{
    var TILE = COL_TILE_SIZE;
	
	DDA_INFINITY = power(10, 30);

    var dx = _x1 - _x0;
    var dy = _y1 - _y0;

    var rayLen = point_distance(_x0, _y0, _x1, _y1);
    if (rayLen <= 0) return { hit: false };

    // Normalized direction
    var dirX = dx / rayLen;
    var dirY = dy / rayLen;

    // Current cell
    var cellX = floor(_x0 / TILE);
    var cellY = floor(_y0 / TILE);

    // Step direction per axis
    //var stepX = (dirX > 0) ? 1 : (dirX < 0) ? -1 : 0;
    var stepX = sign(dirX);
	//var stepY = (dirY > 0) ? 1 : (dirY < 0) ? -1 : 0;
	var stepY = sign(dirY);

    // Precompute tDeltaX / tDeltaY (how far in t to cross one tile on each axis)
    var tDeltaX = (stepX != 0) ? (TILE / abs(dirX)) : DDA_INFINITY;
    var tDeltaY = (stepY != 0) ? (TILE / abs(dirY)) : DDA_INFINITY;

    // Distance in t to the *first* grid boundary on each axis
    var nextVX, nextVY; // world positions of the first vertical/horizontal boundary

    if (stepX > 0)
        nextVX = (cellX + 1) * TILE;
    else
        nextVX = cellX * TILE;

    if (stepY > 0)
        nextVY = (cellY + 1) * TILE;
    else
        nextVY = cellY * TILE;

    var tMaxX = (stepX != 0) ? (nextVX - _x0) / dirX : DDA_INFINITY;
    var tMaxY = (stepY != 0) ? (nextVY - _y0) / dirY : DDA_INFINITY;

    // Normalize tMax if dirX/dirY are negative (division handles sign)
    if (tMaxX < 0) tMaxX = DDA_INFINITY;
    if (tMaxY < 0) tMaxY = DDA_INFINITY;

    // March along the ray
    var t = 0;
    var MAX_STEPS = 256;

    for (var i = 0; i < MAX_STEPS; i++)
    {
        // Step into next cell
        var normalX = 0;
        var normalY = 0;

        if (tMaxX < tMaxY)
        {
            t = tMaxX;
            tMaxX += tDeltaX;
            cellX += stepX;

            normalX = -stepX;
        }
        else
        {
            t = tMaxY;
            tMaxY += tDeltaY;
            cellY += stepY;

            normalY = -stepY;
        }

        if (t > rayLen)
            break; // we passed the end of the ray segment

        // Check this cell
        var tid = tilemap_get(_tm, cellX, cellY);
        if (tid != 0) // adjust if you use a different "solid" convention
        {
            var hitX = _x0 + dirX * t;
            var hitY = _y0 + dirY * t;

            return {
                hit   : true,
                x     : hitX,
                y     : hitY,
                nx    : normalX,
                ny    : normalY,
                dist  : t,
                tileX : cellX,
                tileY : cellY
            };
        }
    }

    return { hit: false };
}