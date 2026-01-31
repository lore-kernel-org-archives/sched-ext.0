Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66835284672
	for <sched-ext@lists.linux.dev>; Sat, 31 Jan 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769850149; cv=fail; b=ZXsvKuhLug89/XekpQeZIIqb+2OKK1RkEC/ml2W98wLrFyTK8BOoG/HJ1+LlaE6avR/vRKKJaIPV4q9SpLTNlT16HzE0mdAm3hEpk5MQdUCEjp67ovrvtB3g4hHEzVju+TdO6l2HLjBzv16+oVERHl6SBtANeFDdlKZP+Att+cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769850149; c=relaxed/simple;
	bh=TcJC3jNI7ZTrk22j4EUporA+UDdTFynFJi5fTw/HtQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wh95DTBzt/Ed38A/m/CfxTgFjv8faXU792Pdbkp26boVkILgBuQNwdXSStjcBi0o0jsEAncMOOMLIt1KQddxGHTcx5TmtxR17RTP4LdouraHiH2eyLVeitNhrs7zuTtefF6fb/CgWo4Lh4sCxJnsUOcefmnPdeDH5yiWKCm4AZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OEN0r1fI; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OEN0r1fI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd1RiS8JaY4A4d5i2Oo3/x+S8Y5EReEcmcVgT7OwGcbBIAVsa7/OXyfwNS/00rVEZhG+ljoPzjDvlM34lrS5BlUFSSR2cy8hKMyU+gZDwfC8hv/gQfbu3DhlP0XFQze+eyKS8ZbsvtL+aJLgPy7AnnYqbMy8FEENUUZL4xp9bgqsEFQGOfBR7YqJJHbfHX8phxyDuY0EgFNYKZY1IJM0TkeLXTYgo6aQOOJtul9bPWdqxpp/ReMxbmtX7ZudVSj6JGRDzZBDpRGOR91y/50fE6XlAtcubBlNEKIiM4tYG2gMApGq+x+inRwKLkMsjwrcSoiDhi+1fV5zilnc066ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUJko6GCNoraiPTVmZBX6jI/DJqOATVqGBXeigkEJ4U=;
 b=wOz+ZorgdF+KcJdRu9V1/uTbh8YAjvsjYw93hk3p9/46KWgqPJxp1Ycz58meW7fnN6WaXmtbRcJuwb0fiW1zCUg0V6LPaBMCmxD379/GepW5zArrtFb6uLpa4eNQ/+t+a7g3W4nTvxC3rRbK99rq+7/wzWwG7PHW6fBDFacz2LJUtgMj+VbVB9mBWpVvERgCm1+v0f1XIK0iOzjna/kxwko9UoKMMyOUywNDELaEOeMwNoYUNn94avxQThs9u1Smh0cB7SY8AbeBuuH8GvQSUh8MhYdNH8r/VDyUc/DCFcWrav3+Yrg5bOp1SVmVeMNWUMlund5E1g0emxrYGzIkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUJko6GCNoraiPTVmZBX6jI/DJqOATVqGBXeigkEJ4U=;
 b=OEN0r1fI6jsX9Vi3UqoEOqNxNzbYZw+nytRvDfJ5wUaiwudeAk+d4pFdHvqTe6j2B07WNwG9H7CUoLnw1zeD9wUqPWuBXQcwbxJ8aVVwfsFJUq4dDvXD+ZBGFCtQP4awHiNg/RvtZModPRdfrZ/G2XIBVd3ffDRl+021mGCzXEwzioY6B98jhxKrYUdci+33vzPpGb/rYwwVKBKxvUQMf0g0snf2IwVBLZ1M3XQSFRkf8di9Cyr6JE02ilbg7EuGFCm3NO1yt3An8V5kxsw6ZnfQL1iSezJsUZ3guyh8VGZlLl4DvkDojzo8M+f0/E5pciSZRly98ANLhUM6gEAwyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 09:02:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 09:02:23 +0000
Date: Sat, 31 Jan 2026 10:02:19 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aX3FG00RNMv8VnQQ@gpd4>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org>
 <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: a7603c16-ce5f-41fe-1a7b-08de60a77237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z09QTjBFdXJqc2ZzZXhsNTc2N0xLaDV3N0k2VC85RnFBcGxFWmxUbUR3dEI4?=
 =?utf-8?B?bGpCWnA3SGN3a01PeHVrSjJuWktwY3JsbjM5aFNKZXRuL1BYcjB2NVROMnJX?=
 =?utf-8?B?VkpBTTBKcHdNbE1xWUdYa3gyemxCem9aODc4WmlpRElYMDd1RmJtYldabFhU?=
 =?utf-8?B?eDVZQVoxWWNVTld2NkczWUoyeTFOYlJsaGlFemFWZGZQRDBRRVI1TXRuZEFv?=
 =?utf-8?B?M0NCTVVYUTlSNFNEOVNQU1BSbXk2S3F5YUdWcGpWWTRXVDJzVVIxUWtZWTFm?=
 =?utf-8?B?aFN2Qk92RnJNUUNLRHNnNllxZnRPbzhNbndjaFJJeUNYUmdzY1FiMmsrK2lP?=
 =?utf-8?B?bkdwY1p5L0JZUlF2SW55endQMWxaS0FPRnNVRHdxWmFzM3N4M0l0blFzUHYr?=
 =?utf-8?B?Y0ZnN1NoTW83RCs1V1NhOUlSamZnSDBFRHgwc25POUxiSEl5TVV2b3FRc1F2?=
 =?utf-8?B?c21MNHRwc25UcG40bHdpR20reW5XVUJ1eHR2S2ZHK1lhYUl4VlBJd24wekxq?=
 =?utf-8?B?bDByWmdudHo3NFAzb0JKNUNSK3d1SS9XZEFHZlFrQzArN0VEdmRFS3ZOK2lX?=
 =?utf-8?B?UXBjN0JrTzY3M3dCWTJkb2VHdGgydVZJVnkyRWRwN0lNQVN5L2ZoQ2NGUUls?=
 =?utf-8?B?N0wxelMycVRXWTFJYWRPWmRBL0hFZm1VeUVGaEZjL2ltSU5MN04rSUViOE5v?=
 =?utf-8?B?S0JIc1dEUEQzMXhqMHBiM2RzRGwxaEt0ZWN1WjU5blJmYnVaeVBkMmRRckJr?=
 =?utf-8?B?TkpwTTB4YWlNY29QS0l1M2FFUmMrVU14TGRaWUFSa2lOVkVReFNrM2lvYVVm?=
 =?utf-8?B?Snp0SG1FRXVtNkt6SFhGTW0zWUFMN0pLRWU2OVVuaU1YbVhSS0dNLzh4ekov?=
 =?utf-8?B?eWtlajEwbDFXbFYyM2V4RUVzckFHSHdGcmhxeVdsS2NrVGdzUjZiSkdNM3dC?=
 =?utf-8?B?WE5OU1RjNWNKRjYxVUZ4Zi9QcVZiKzhpL1h3d0dZVjA0VFRXQmlXaVNLZzQ2?=
 =?utf-8?B?MW52THRpRW9nL0JoZi8wZ1FGQUZwa0FUc0JtcU9BandGY0dCdXJUUWZYR2hT?=
 =?utf-8?B?dFF0Z0FqK3Q4SDB4TWdqenBDNUliN0xRRE5McXBZakdzYW9KeXg4MW9vNnlY?=
 =?utf-8?B?Wm9GZ0R1K2NjbFF2dGRxZkdkTnJSdVR0bzNZQlA1elFhT2loanI0eC90TWFm?=
 =?utf-8?B?SjNxSHRrVkIzdXVqS2NKTEpoV3h5T21iN1o5RUR1VE82aHoyMVllcTNDbmJy?=
 =?utf-8?B?anMvckljVG02ejRjTmVVTWt5TTByRG44dmExVmoyZ2NtakE3S3VpQ3BZSC9E?=
 =?utf-8?B?elplaGtQMHM0S2hqVVhOOFcwYUpLV2VQTHg3V01kSjlUT2xXOFY0dVNOMUk4?=
 =?utf-8?B?YWRRT0RpVHVOMHNWb2dFdlltV3FkUzFZOURxMGVxMjAxK2NTZENhcks4WG5p?=
 =?utf-8?B?VG5zSmprS2ViN201cC9mWjgzT1JXOGJzRnNHSEN1Z1dmREk2U3dSL2ExWDZu?=
 =?utf-8?B?N0kzYzlDS2piTTR5aU9YWmE5L2NjbTY2YkhxY2t4ZG0xaWNlbEFUYi82TEVw?=
 =?utf-8?B?TGdPRXdkTDZjeUtRYWNQOFZOK3c2MERyZXY5NDdVV1JLblViL1RhU05uZ1l5?=
 =?utf-8?B?eXQ2VDErTWF4VXFlMzNJZ1VSZnpReDJvaUV5UGlnYkZ1bVo4QmdILysrU1Ux?=
 =?utf-8?B?RTJCK2NnRWtaaXZuK0pCanV3Q0ovSWZ2UHcrQ2lEamRHQmhXbXBhQlVFMVhB?=
 =?utf-8?B?VHJhckxTSU0zZndNcEF4RzZpb1NZQ0RvMkFMOFhsa2ZUQmU0NFMxQVRBRjlo?=
 =?utf-8?B?UHVtNFlJeHBMaFVZcUE3ZHloenhDeDFDb29qOVY3d1IyVVdMc0ZYaU5zOFMw?=
 =?utf-8?B?d3hhQk1zSVNlNUx5eWowUTBsVFMvZW5wYStGQzdFbFcyUTJWTk1GY0J1dXV0?=
 =?utf-8?B?TDRMNDNwUi9IdXE0UkkxOG82SUQ2NTlwTFlROUZELzZsNVFVZEovRnA5WkVh?=
 =?utf-8?B?OEZDQzFXbXRUNENTNGlkNTEwK004ZzlkV2l6K0JoY3plL1dvZEROdll3UjIr?=
 =?utf-8?B?VGdmOW9oMllpUlhFU25OcTFFWitmYTczZk1IME5jclYva0hlQ1FSeFVNeXJI?=
 =?utf-8?Q?FzTfCvOSNOSX8jHjbsiObfAld?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUw2Q1JHM3htNFBJNm5haEJQc096dWRqSUJ3cFhNYVRIQlo5TDNYQWtJWnhB?=
 =?utf-8?B?bk9KaVdONThEUHMxaWwxRE52eGMwNkRDamVVRWNQYUhVMEdGZHI5S1Z0aDhU?=
 =?utf-8?B?bkkrY1oyeHh1SzREVEpiZnA4UEVuNEh0YXpicXNQNnpSc2VRSFA0eGJoZjJP?=
 =?utf-8?B?QWRtUHJtSExMVU9Bci9nR05IcC9BSFlnc3c5MFlRYzJTdmNvRjkzSkFyeVo3?=
 =?utf-8?B?SGhucUp4aHl3dzhkK2lBYmh4Mzk5V1J6RmoyWUFlTVF2RGtZcTcvUjFwWW8r?=
 =?utf-8?B?Y0QxRjRFK1puL3VOZjNYMW90SWhwZ2FUQ3RMWXUvSlpXK2VaZlVDRHV5UUs2?=
 =?utf-8?B?bm13b3AvZzNSdHhkRzM4Tkh2eVNQWU5OWTdqVHBFaDhMV2lHV0hnS3duc0E5?=
 =?utf-8?B?TFl3dTJLSVBObDZ3ZW0wSS9wMXRtekNzd3FLQUVHbHZRV1ZDUWZLUFhGUHVH?=
 =?utf-8?B?NU9WWHZkMTJkRkpEOVNmZlpPOVBtaVRSVnpSUXVhNUFPMlVGTnAxNGFkQWZ4?=
 =?utf-8?B?TXJUU1I4cHVVTk5YdW1xQXpBL0Z2YTZQYk45V25IenNQNGpHS2haUGhFa24x?=
 =?utf-8?B?OTVmVFRzeUdxOU83WDhVaW0welIyeUNIV215TGw5cWpnS1dHd216b0dqK1Jr?=
 =?utf-8?B?MFdZUTk4Y2kvY05KMDQrZDM3aXNRU1E1UGVFclNvQ0Z4VjZnQU1NSjIzNHZm?=
 =?utf-8?B?d3BKZ2xZbnhNVVh1N0xBUVUzYlBoakxZajdYd1JsWUQxQ1llZjFrZG9tOWcw?=
 =?utf-8?B?WFF1dHdBV0x5aUFYNWRmRW9ZeFlWb1pPUGl6V1JSa3I5UWFnSURXdmZIUXBt?=
 =?utf-8?B?SGhqVGdoUWdiZVg1bDhZKzBmTWRBUkhyRUxzSTdIWVl0NitDN1ByVi9wL3da?=
 =?utf-8?B?dm5nZ0h4ajVLSXJidTBTNzdCalp2K04xN1pSK3M3cHg0eGhzYnI4NTd2Nlhm?=
 =?utf-8?B?SmtsbmlLOVZGN052QlFOTEtKaFk3VTkvS3JodDNOenlubmc1T2FnRG1KUFFK?=
 =?utf-8?B?b0ZONUdNR1IvTFI2SDRleER4aGhWYXdQYnA5K2FWbUEraTNPTGtxd2ZEeThp?=
 =?utf-8?B?aisveWM0VnNsUy9LR2tnZ1BKS3BnNU1XemR6NTRheGpxUGd5aGQxM0dBekkz?=
 =?utf-8?B?SXN0NEtzNnRXMmJQNU1iWG5jVkVoZ3lNTC9hdTAyeUlNdmNINXU1S05NSjdl?=
 =?utf-8?B?ZXBKc2pSV25PS0VTWmdpbEd2QjNaMlpjTmZHd2liQ3Q0SlhiN3N4UWU2c2M5?=
 =?utf-8?B?elpIVjFNVEJYdFVLS0RRalhwdFJManpOVSt2RnRUb2EzS3hpbHlTZTJGbDhH?=
 =?utf-8?B?K1R0V3FndXBhSngwcjVVc3pMeHNHNXNJeG5VN2RLRUlYV2JsREZyem0vZWE3?=
 =?utf-8?B?WFZIN0JPaTZ4M3Bnd01BN0t1NnRvOU4rc21pdHhVc3lyM3M3UnVrTDNpS3Iy?=
 =?utf-8?B?SVJPSURoMWRoaGlkb2J3Y2dQcjFUcUtJMG9CWUs3NFlZOVplemxRYzVyTk94?=
 =?utf-8?B?N0FKazFEQ0tzNjVrM3p6RnFnUXNaSytHeHdIS2k2YkgxcDhaOVVmdHFKb21p?=
 =?utf-8?B?Ymdxd2dPR2tBc091TGYvdi9BTk1VL0M3TFNjdVl6UlBzSVRIMTYzbHN3OFhB?=
 =?utf-8?B?STltZzRWWjNXTkQrejI2M3d5TDAwbmc4a0lnUEk1T0daS1JqNStxMk16cXJE?=
 =?utf-8?B?eWZxOGVwUU83bVNzaEdwSTBEanZOM1RtKyswYTBaZ0NncTloOHN6YzBBTkw2?=
 =?utf-8?B?TzNzdEdwazJwZ1JoWUhxUmZ0dGRtVTVlN1EwVTU3cDVUOVFPQlFVTWpTS3F6?=
 =?utf-8?B?ZGkyN09HUDRVMG54cVM4SjcyK2h3OXJXai9CWE0xUzlqcWtkWWFFME1zbnZz?=
 =?utf-8?B?c0EvcXlBWHVLNzE2VmthNytia1MzSzBRVkpIcnRGOFV1ZG1ZMEZERjZpK0xB?=
 =?utf-8?B?V3hBRVRhWVlxSkZOTlA3TThYaFg4dm1WZis3ZDBsd3QxVDc5cFdHZjlManNX?=
 =?utf-8?B?VWZ6UWxLcVF4ZkNiMjhzdWxoelY4aFZBYUtOWDRHVEQyODl0dHBjZVU5Y2xa?=
 =?utf-8?B?MEZmUEI1bzkyWXYzZ0VYbitOclY1U2Y1RTA1M01ydm1HSDBRVHVVTkU3aEt2?=
 =?utf-8?B?bUoxTVpJNXRJSVVqWlBPNWJyZXQzazhOY1dyRS9tVVorUmhrVlEwZHBPTHl0?=
 =?utf-8?B?Z1JxQkFzWlpvOEYyN3hLbHNKREIxUlJhWEF6bG0yMFhYQm5Cc0hwSFVra2k1?=
 =?utf-8?B?dU9nV3VhRzZpVndvZjdralpidVNQczNBQUFHdkIvaVZrYzIyNytLRmJnd0I4?=
 =?utf-8?Q?Kf1TOX1xRJEzX4sgbI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7603c16-ce5f-41fe-1a7b-08de60a77237
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 09:02:23.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnXRUASjDT/t8U7Vpyn71tr3lIdMxvVi/1mMtdYj+dl85jYKUt3N4PypDQSVMvUtLA7dZ+nxMbrai40xNVSfWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

On Fri, Jan 30, 2026 at 11:54:00AM +0000, Kuba Piecuch wrote:
> Hi Tejun,
> 
> On Wed Jan 28, 2026 at 9:21 PM UTC, Tejun Heo wrote:
> ...
> > 1. When to call ops.dequeue()?
> >
> > I'm not sure whether deciding whether to call ops.dequeue() solely onwhether
> > ops.enqueue() was called. Direct dispatch has been expanded to include other
> > DSQs but was originally added as a way to shortcut the dispatch path and
> > "dispatch directly" for execution from ops.select_cpu/enqueue() paths. ie.
> > When a task is dispatched directly to a local DSQ, the BPF scheduler is done
> > with that task - the task is now in the same state with tasks that get
> > dispatched to a local DSQ from ops.dispatch().
> >
> > ie. What effectively decides whether a task left the BPF scheduler is
> > whether the task reached a local DSQ or not, and direct dispatching into a
> > local DSQ shouldn't trigger ops.dequeue() - the task never really "queues"
> > on the BPF scheduler.
> 
> Is "local" short for "local or global", i.e. not user-created?
> Direct dispatching into the global DSQ also shouldn't trigger ops.dequeue(),
> since dispatch isn't necessary for the task to run. This follows from the last
> paragraph:
> 
>   Note that, this way, whether ops.dequeue() needs to be called agrees with
>   whether the task needs to be dispatched to run.
> 
> I agree with your points, just wanted to clarify this one thing.

I think this should be interpreted as local DSQs only
(SCX_DSQ_LOCAL / SCX_DSQ_LOCAL_ON), not any built-in DSQ. SCX_DSQ_GLOBAL is
essentially a built-in user DSQ, provided for convenience, it's not really
a "direct dispatch" DSQ.

> 
> >
> > This creates another discrepancy - From ops.enqueue(), direct dispatching
> > into a non-local DSQ clearly makes the task enter the BPF scheduler and thus
> > its departure should trigger ops.dequeue(). What about a task which is
> > direct dispatched to a non-local DSQ from ops.select_cpu()? Superficially,
> > the right thing to do seems to skip ops.dequeue(). After all, the task has
> > never been ops.enqueue()'d. However, I think this is another case where
> > what's obvious doesn't agree with what's happening underneath.
> >
> > ops.select_cpu() cannot actually queue anything. It's too early. Direct
> > dispatch from ops.select_cpu() is a shortcut to schedule direct dispatch
> > once the enqueue path is invoked so that the BPF scheudler can avoid
> > invocation of ops.enqueue() when the decision has already been made. While
> > this shortcut was added for convenience (so that e.g. the BPF scheduler
> > doesn't have to pass a note from ops.select_cpu() to ops.enqueue()), it has
> > real performance implications as it does save a roundtrip through
> > ops.enqueue() and we know that such overheads do matter for some use cases
> > (e.g. maximizing FPS on certain games).
> >
> > So, while more subtle on the surface, I think the right thing to do is
> > basing the decision to call ops.dequeue() on the task's actual state -
> > ops.dequeue() should be called if the task is "on" the BPF scheduler - ie.
> > if the task ran ops.select_cpu/enqueue() paths and ended up in a non-local
> > DSQ or on the BPF side.
> >
> > The subtlety would need clear documentation and we probably want to allow
> > ops.dequeue() to distinguish different cases. If you boil it down to the
> > actual task state, I don't think it's that subtle - if a task is in the
> > custody of the BPF scheduler, ops.dequeue() will be called. Otherwise, not.
> > Note that, this way, whether ops.dequeue() needs to be called agrees with
> > whether the task needs to be dispatched to run.
> 
> Here's my attempt at documenting this behavior:
> 
> After ops.enqueue() is called on a task, the task is owned by the BPF
> scheduler, provided the task wasn't direct-dispatched to a local/global DSQ.
> When a task is owned by the BPF scheduler, the scheduler needs to dispatch the
> task to a local/global DSQ in order for it to run.
> When the BPF scheduler loses ownership of the task, either due to dispatching it
> to a local/global DSQ or due to external events (core-sched pick, CPU
> migration, scheduling property changes), the BPF scheduler is notified through
> ops.dequeue() with appropriate flags (TBD).

This looks good overall, except for the global DSQ part. Also, it might be
better to avoid the term “owned”, internally the kernel already uses the
concept of "task ownership" with a different meaning (see
https://lore.kernel.org/all/aVHAZNbIJLLBHEXY@slm.duckdns.org), and reusing
it here could be misleading.

With that in mind, I'd probably rephrase your documentation along these
lines:

After ops.enqueue() is called, the task is considered *enqueued* by the BPF
scheduler, unless it is directly dispatched to a local DSQ (via
SCX_DSQ_LOCAL or SCX_DSQ_LOCAL_ON).

While a task is enqueued, the BPF scheduler must explicitly dispatch it to
a DSQ in order for it to run.

When a task leaves the enqueued state (either because it is dispatched to a
non-local DSQ, or due to external events such as a core-sched pick, CPU
migration, or scheduling property changes), ops.dequeue() is invoked to
notify the BPF scheduler, with flags indicating the reason for the dequeue:
regular dispatch dequeues have no flags set, whereas dequeues triggered by
scheduling property changes are reported with SCX_DEQ_SCHED_CHANGE.

What do you think?

Thanks,
-Andrea
