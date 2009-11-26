﻿/*
DataMatrix.Net

DataMatrix.Net - .net library for decoding DataMatrix codes.
Copyright (C) 2009 Michael Faschinger

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public
License as published by the Free Software Foundation; either
version 3.0 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

Contact: Michael Faschinger - michfasch@gmx.at
 
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataMatrix.net
{
    internal struct DmtxFollow
    {
        #region Fields
        byte[] _ptr;
        int _step;
        DmtxPixelLoc _loc;
        int _ptrIndex;
        #endregion

        #region Properties
        internal int PtrIndex
        {
            set
            {
                _ptrIndex = value;
            }
        }

        internal byte CurrentPtr
        {
            get
            {
                return _ptr[_ptrIndex];
            }
            set
            {
                _ptr[_ptrIndex] = value;
            }
        }

        internal Byte[] Ptr
        {
            get
            {
                return _ptr;
            }
            set
            {
                _ptr = value;
            }
        }

        internal byte Neighbor
        {
            get
            {
                return _ptr[_ptrIndex];
            }
            set
            {
                _ptr[_ptrIndex] = value;
            }
        }

        internal int Step
        {
            get
            {
                return _step;
            }
            set
            {
                _step = value;
            }
        }

        internal DmtxPixelLoc Loc
        {
            get
            {
                return _loc;
            }
            set
            {
                _loc = value;
            }
        }
        #endregion
    }
}