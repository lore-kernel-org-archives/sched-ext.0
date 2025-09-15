Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A072C0F67
	for <sched-ext@lists.linux.dev>; Mon, 15 Sep 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922039; cv=fail; b=SRU9iPdDLIJaQvL/EfHhnI/B4pAcXqssQI2X5RI8nIQ3ytD68929X+ogI3BirXHOM32WAMS3oFzQOCfvSTyiYoL+MF13aVLM3dSzokI8fWNN31UZ1Jh6vyZiGjJ9ZEZ0vSJV0shGO6c4tQsuKL8eITNrHsrnoymKuobZvhFXyXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922039; c=relaxed/simple;
	bh=21Nfj469sB90wx/Uy1Aj8bWHCHoCyI+k9AATCCwiTgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nfrY4BVy7OWAUN5msZxiBQQAyLsZhxYHvw1DFI2ErfZVqM5R4BD9T1wp4pFtWvp1eWx+bw5qa8Cu+XiLR58pw9k209vBHyGNc+Mp06W4Li+Beu1ta2xlZvyRYiZTL6nUhMI0S7peiO4nk+2Q1WGflOAqMnwGPAWT45igy9+Skrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTU4D3SA; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTU4D3SA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgkfXXpMAEhV2kyQipGqnV77DAc3NMkQBwa2wzXZd63y1RYWfSu3DwQ4qJ1d4QyGn/XcgOITIVwp1srTArqMM1rYBiXGSsW1QgrgAoviSb4kC606MjXIM8G9qisrUcZ1G19rjYwOwHXgHa+2l0ch9YV9llUEmpJs7mskTOul7BFbXE+tTQG/XOSUZbfKbab3ZWXYhtAD/4WjgzhaNTgxvHNyo3D3bFJEW24Pt5g4HryQhyBl+QtTahU0EOCNYkO5oMS9hn92HzBw503lzbNj+d/cVSPh7o38x9xre4laCgjrIjJxx/bhfaRbFhF7eT2m4+Imj+9jgRd1wMCdOppyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhHARe3kys3xRiFrduOASa8B7fEu3YK2bjDeVE1oFVo=;
 b=M11whnE4MQVepbYWLcXZwrA+ttVwBCO2HqYu6WmfZI0rKxcSEbE+eXWO/PH9d0kcfrDf0Mthw8d7WRW55qOdXRSokPM9YDS6tYmhY//6Bpi0BYGwMIzdq1XB5VMErSuH7vO421mT3RxXTU68pVHAdDDE977cScLw1RTDh5bmQtIKPpCSeDRRS062SNsi2WLliB6e6GLKRfjQUwmshYh9f2xemX8EpY12V1sTmzrmpoov4Wv98UIKtlAV94hS22vvU5hpSuh/SlIB83DEp2ZWwTgqP9xxF18DB2V6VoITuPmYIVJmj0LtVUDP1ByjeZI6uvuylFUGYGkNtq7MjktlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhHARe3kys3xRiFrduOASa8B7fEu3YK2bjDeVE1oFVo=;
 b=fTU4D3SASXExjZEWbG2LVDYVFc6+avdjitgaNHezy5s5yRMBJEeBZ6sUegUFL+gTXFi8lHQcQQX/ZHcRG8ugD2gEnLaZu6N32MMK/pqu1ZYhkSqhPiGVrSHIlwKcLaP+3ypIJP7NvXZ/ZNDRNB5d8QcEt/BGa8IiQxMz4cq58RtFPi5PNHmxbJIzEmMn1fYI4fueDqa829VWUa4cEu/66Eji22f19CD0/ma2YVtAQtkXLXuhuj0q2ME/Zkby79+yIj1zTQeHbjjc5kD8RQ+cnoZCI3PjckW60HGr8nKg13FQ8lDtP/YqHiQfgMPM4lOzGoVBHDrsQWmo0mnQZx7/Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 07:40:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 07:40:34 +0000
Date: Mon, 15 Sep 2025 09:40:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "sched_ext: Skip per-CPU tasks in
 scx_bpf_reenqueue_local()"
Message-ID: <aMfC7sxzVYbRKYps@gpd4>
References: <20250912161438.529446-1-arighi@nvidia.com>
 <978215f1-40d1-4c77-b436-2710029d5acc@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <978215f1-40d1-4c77-b436-2710029d5acc@igalia.com>
X-ClientProxiedBy: ZR0P278CA0121.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 773464a3-6317-4a5e-3b8f-08ddf42b2766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3pFQ1lhUlBld0RxcUNuQWh0dEptTFhwTGF0QmYzZlVjQ0R4NWN0WG5nbUc4?=
 =?utf-8?B?bm1sR0duVHk4NGp6dTFYK2ZBbUw4VEFrOUxYVkJydzNzRXNNM0Y2ZFJreG9w?=
 =?utf-8?B?NVNUS0I0amhEbUNQdEthekNZRmhaRHZSMk9LeE4yR0hiY3hoMGJHVHFxMEND?=
 =?utf-8?B?SFloTEwxTzhoVzMzc1VHRFdBS3Y3eWtseGd3NVlhMTExUHZ1cGxUQjlmd01l?=
 =?utf-8?B?c2N6Mzdaa3QvODlTVW4wS0xtMmtDSDhNNFF5TE9SQWtKcEJXNm1DSFR3SVNS?=
 =?utf-8?B?WTR0ZmpmOFNqbXZVcjRGK0tZRmVEZ1lmTGs5RUM0T0ZuOVhtTjgwaWJ4TzVK?=
 =?utf-8?B?UU5UMGlIbXVBOHQwdU1NZXN5Zi9PMGUyQUJZeWJrcXgxMjZBZDZGRHVRSHZo?=
 =?utf-8?B?dW1kMU9EeSs3SXN4Y0xjQjQyOUtGY21idG8xWUJia2h4SDUvVFJKb3RSVEM3?=
 =?utf-8?B?a1lyOHplK2ZMeHRFekpzZ3RoRW1DWnFvdFgvOGlmSUZ5ZmxITmMwcVZwWWdG?=
 =?utf-8?B?MU96NkdmNDNJVkRPYnpUTTQzVnJRMHlieWhBWW5haUNSeFFuWS9kNGs3VFlp?=
 =?utf-8?B?SUhoMGhuRmRMd1NGck9ocDVvbmczZjZiOHo3TWFPNktMOVdic0lOM1QwK2ts?=
 =?utf-8?B?cXhaRVlTbXhuWUtaUmEyUklxSlJROGZ4aFRTcEdpM2ZxMm1sWDZNb2dwR21D?=
 =?utf-8?B?cnRVcHdzSnl0N3lRNHNGV1VFdHhmSUUrWWNVeGduMjliMGhRZFlvUVpsTVp0?=
 =?utf-8?B?TVN5a0d6WWJHQmJ4aG45N1plVWpKY09qcW1uWm9Bd05hbVQ1RWFOUFJHckVB?=
 =?utf-8?B?ODRWbTZ0UXBKNm9VR3grNTNHVUVsV3R5VHpRYVhldEhsaVpBT1MrY1NWeGRE?=
 =?utf-8?B?UlFHVHdlSXZCNTl4MWFidXZvRVdFamt3bzlqZjBURjdHU0xCVEpuN0FvcWs4?=
 =?utf-8?B?a1FUNmViNS9CbCtQdFU1ays5UkdsUUN6dlVnRnlyeG42TWRRQi9yT3VHSDF4?=
 =?utf-8?B?b3ZEUDRqL0gxM0duUFI5T3I5Ri9ZSjNlZ083SU1ETjByNnBjb2JoWGdXTjd4?=
 =?utf-8?B?ZDZraG8wZXdDdzNmV1N6bmk5UTFwajByandPVFhKek9QWFJOeHQxWit0dTF0?=
 =?utf-8?B?WDRCaEJmTmhoSnVqV2FNUVgrc3RLY2JSdUhoNEFMVFV1ZFVFcFFTRHJqMjhq?=
 =?utf-8?B?bHZHbWFCOENmeUExUTc3QWV2R3hkUUJJa2EzSm44aUN2aHYrdmR3MENRYlNM?=
 =?utf-8?B?cXhTaThHMCtxRVJuekhHcjVZQXVPNm91d0xDR3FPd2hpblBBM3ZrcVArdWI2?=
 =?utf-8?B?SUNvb2VtVklCTzROSGJxODV3cDY5V0VjdUVsaHp0bTBldXZSWnhFb213Ukk0?=
 =?utf-8?B?SEJtN01rcDVTdlF6THFMYjgrYVB6dUtRWk1GOCsyMHI4ZHd5RlZwZTRLMXh6?=
 =?utf-8?B?dWF6Tjl6bUgwb0dWUDdFMlpCYWgwSWVXS3BuYnNxZXFBbzl3QUZka3ZXTkox?=
 =?utf-8?B?RUxUM2RWSHpkd3ZlaHV4RGRIZTNBVlJrU3F5ZUhTUmoxSVd2Q0tNTmp2eXcx?=
 =?utf-8?B?NHA5azNweFhxUWhvSkdSK0VBaTBOZXRJcC9iNVFpejNZdDZrbWYrM2xvbS9K?=
 =?utf-8?B?WWpqWWlOdUYvQ3ZZMDV5VDV5MjRWNERGcUFQYnYveWdkcVZrOUdqaUJJRDhK?=
 =?utf-8?B?RWkxaDV0RDNtWVZzZitxaWtTOGZvL21nZUlablNvbnVxeXZXQUpDVDNkTjBM?=
 =?utf-8?B?SmNkT0p1TGJudlNwbm9rZXIzak9WK09SMzBwWTkzU3dKdmR2aGNWazMxVERF?=
 =?utf-8?B?SHhSU3Y1VVdpeU43T1ZOT2RTYVlyVFV6QTQrNENBRDdFVktvcW13a0x4UEQ4?=
 =?utf-8?B?R3NpV2hZNHdEQVdPcVBiUVAyT0NWbUxpRXovMXAvLzdMSjl5K3h2NlVqcFk0?=
 =?utf-8?Q?zW77UxTaQD8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NklIYXBFUytadERXOElPZGVnbnk2eDRva2RacEdWQVJ3aFB2S3FMNjJnU01z?=
 =?utf-8?B?dnlQK2haSFFMbE93WTJMMTQ3bG85WlFPRHNDQUZmTmUzYjZFWW5wa0FSS2tr?=
 =?utf-8?B?T1FMQkFOMmlaT2p4MzIxMEJ3c2xkN1NjRFErSnFMbnI3K2QySU9ueGlaSFR0?=
 =?utf-8?B?dmpZUVJTajFUc3V6Y3hEbDBEdHEvOE9qSzF0QVM4eE04NjQ5SkFjQTF4QklV?=
 =?utf-8?B?QXZtdktMMEVxdnU5VjFGNktIQ2haL2dhaTlWOWdvUjkraGlKQ2RtNHZnNFlN?=
 =?utf-8?B?R0RSeTA4QlRsdDhscGJTVHhHUXhJVXFIOWZOWGgyNy93ZWZRU3diQkwzQ1dR?=
 =?utf-8?B?VCtPbGhQWDV5M1UxYXlnQWt0cFBBeXF2TTlDQ1FlWjJ3VmNJNURnaHVBUnE5?=
 =?utf-8?B?dElRZ2ZQeU9PTVVyTUxGa1F6Q1Q2YnJ1T1gvdVM5YzBOZUFTT0U3b09vY3Y2?=
 =?utf-8?B?bWxXK1QxVFgxeCtDaVRLTkNORERDVDFoUS82RlVWN0ZzV0pjZ3RmenQzWG9q?=
 =?utf-8?B?TFRpOVVRRnd1T3p3M2lzY2ZFM2FmTUZNK0JRa0F0OUU3R2p2aFN6bjNCRzF4?=
 =?utf-8?B?T0JpWDJQS3N0SXF1QXFUQ3J3bDVscU5DWnFtdHZlUmVzZzdObzRMWUVNRjkr?=
 =?utf-8?B?bEVOUTJsQXBjS3UrYTF2M0czTitkN2QzTm1sSkxwUms1UVNNbnQyTmZxbjl5?=
 =?utf-8?B?ejFSUXY1SFpDc3gzdm1hcXJYaVhIRUE2VU43ZWRCa29OS2UydzhSaTJPeitr?=
 =?utf-8?B?K1BZb3FvaDZVa09zZjhGK05IaXJFV24vbXpTcEpIYU1SM1hKaGdGVmVsZzNC?=
 =?utf-8?B?N0h1L3prRmxkdTFRR2RvMTYvRmV2YlVJVEhQeXRldEtneHVmWFYvdERqMkl5?=
 =?utf-8?B?NzhSWHdtbmRoUnczZjUzUE1rb0ZrWDZBRTV6S3pOVktxNnRFUmxPK0dkbC80?=
 =?utf-8?B?RHplMnBmeFFQbm5vNU1BS0lrZnRwZ1YzS1ZHR1UrYS92bVVzdWYrdW9XRzZ1?=
 =?utf-8?B?UzlnWFRrR0NQdi9sbUNOUmdBcUZUaWxLaHE1czdNOE9WMDVwYXhjSk5TZXQw?=
 =?utf-8?B?VkwyYTBXdUltRkRLcmhHbkJ4ZUtYcFpzWWNPTFJOWmJ5SVNoUGFzQ01IVk5G?=
 =?utf-8?B?UTVQVmFFZ3NBVmw0bGtNcGQ4QmYwLzhxMlNrNW0yOGF3bEJvMGU4cDNOREpO?=
 =?utf-8?B?UStGYUtMV1JnTzdXK25jQXhKaGRXWTZ0b3JIUGhaWE9DQnczVHNvcXpwY3pO?=
 =?utf-8?B?VlYwaVN6STNraVc1c1dhWUh4bXdVaFBSdHo0WkR0a3JUOEdwcTl1ZEZRSm5i?=
 =?utf-8?B?WDV2M3RPYnVFUktBaXE5Z0pNS3RoUk5GclFhZ0JrTnVjS1A2MU5ubzZUcURB?=
 =?utf-8?B?K0J4dDVTVkxpelp1bGVpdEF2R2hoWDBGYmZ4TmlId1hyRWUxVWdGK2hEb01H?=
 =?utf-8?B?dis2K1gxVFFNUzJWbEdXZzFsZUEzVWpWWkpnMWtNdnVhWjJ4YzBQWVJHc3Iy?=
 =?utf-8?B?RCtMLy9PeVdRWEZGWllBT1FhamV4b01KcVNiNXM5MzVwNWlJeGN5YTVwRm43?=
 =?utf-8?B?cDBmY21aZERTYnRWRjVuNXFHQmpmYkZQc1BCU1ozYzJSS0s2NUloREU0Rm43?=
 =?utf-8?B?OGxnQjI1clE4bXRKTzNmZENWVk9tVEtKd2ZucGdyRkpmYTZ3dWlGUVd6KzFV?=
 =?utf-8?B?Y3ZxVEdMdzJUcEtPSEQ0UGt3WVpOdUJxN2w5aTlKTEVoU3hySFF5MldHU1JH?=
 =?utf-8?B?Rm1vN0l1QThGa3YyVDJoWUtLdFpJaGNvSVpQNWRaOG9lcHE1NmpDNHNBUm4r?=
 =?utf-8?B?QmVxbFRLVGJyT3h1ckhuelVQS3REc1IzWTNJODY0czFJUHQvVlJ2YnV3QWdD?=
 =?utf-8?B?N2dMY2hYbEhTeWZkODFSTFFCVG1OaDVYMUpGZElUMnhEUlc4VVRPOGpOSWVi?=
 =?utf-8?B?NERZdEdxbjhSblVlRHptY0pUVEZ2TlZhQ1R6WkZsN0o5L3VxcldOWVczUldW?=
 =?utf-8?B?enRBVjVxazZVdmk2TkFoYTRFa3EyUmhRRnpManVuWVRJMkZoS29qYUFsc2x3?=
 =?utf-8?B?YzE3ZXg3dWFxbTJjNk5lbXNRbEtPV3JWWWk1eW83NG1CcnY0ZFR2em1JQnJS?=
 =?utf-8?Q?5UoG+Rkabx+e9LNpn/OWILJvG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773464a3-6317-4a5e-3b8f-08ddf42b2766
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:40:34.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0o0cI5iy5cvwDr4JKy47rXP8q6jgx3SsvepBUtMAxS2mRVoSiFdbxLXs8qwRnGL8qaAabpU9dRRVRJju3q3hqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

Hi Changwoo,

On Mon, Sep 15, 2025 at 04:22:20PM +0900, Changwoo Min wrote:
> Hi Andrea,
> 
> On 9/13/25 01:14, Andrea Righi wrote:
> > scx_bpf_reenqueue_local() can be called from ops.cpu_release() when a
> > CPU is taken by a higher scheduling class to give tasks queued to the
> > CPU's local DSQ a chance to be migrated somewhere else, instead of
> > waiting indefinitely for that CPU to become available again.
> > 
> > In doing so, we decided to skip migration-disabled tasks, under the
> > assumption that they cannot be migrated anyway.
> > 
> > However, when a higher scheduling class preempts a CPU, the running task
> > is always inserted at the head of the local DSQ as a migration-disabled
> > task. This means it is always skipped by scx_bpf_reenqueue_local(), and
> > ends up being confined to the same CPU even if that CPU is heavily
> > contended by other higher scheduling class tasks.
> > 
> > As an example, let's consider the following scenario:
> > 
> >   $ schedtool -a 0,1, -e yes > /dev/null
> >   $ sudo schedtool -F -p 99 -a 0, -e \
> >     stress-ng -c 1 --cpu-load 99 --cpu-load-slice 1000
> > 
> > The first task (SCHED_EXT) can run on CPU0 or CPU1. The second task
> > (SCHED_FIFO) is pinned to CPU0 and consumes ~99% of it. If the SCHED_EXT
> > task initially runs on CPU0, it will remain there because it always sees
> > CPU0 as "idle" in the short gaps left by the RT task, resulting in ~1%
> > utilization while CPU1 stays idle:
> > 
> >      0[||||||||||||||||||||||100.0%]   8[                        0.0%]
> >      1[                        0.0%]   9[                        0.0%]
> >      2[                        0.0%]  10[                        0.0%]
> >      3[                        0.0%]  11[                        0.0%]
> >      4[                        0.0%]  12[                        0.0%]
> >      5[                        0.0%]  13[                        0.0%]
> >      6[                        0.0%]  14[                        0.0%]
> >      7[                        0.0%]  15[                        0.0%]
> >    PID USER       PRI  NI  S CPU  CPU%▽MEM%   TIME+  Command
> >   1067 root        RT   0  R   0  99.0  0.2  0:31.16 stress-ng-cpu [run]
> >    975 arighi      20   0  R   0   1.0  0.0  0:26.32 yes
> > 
> > By allowing scx_bpf_reenqueue_local() to re-enqueue migration-disabled
> > tasks, the scheduler can choose to migrate them to other CPUs (CPU1 in
> > this case) via ops.enqueue(), leading to better CPU utilization:
> > 
> >      0[||||||||||||||||||||||100.0%]   8[                        0.0%]
> >      1[||||||||||||||||||||||100.0%]   9[                        0.0%]
> >      2[                        0.0%]  10[                        0.0%]
> >      3[                        0.0%]  11[                        0.0%]
> >      4[                        0.0%]  12[                        0.0%]
> >      5[                        0.0%]  13[                        0.0%]
> >      6[                        0.0%]  14[                        0.0%]
> >      7[                        0.0%]  15[                        0.0%]
> >    PID USER       PRI  NI  S CPU  CPU%▽MEM%   TIME+  Command
> >    577 root        RT   0  R   0 100.0  0.2  0:23.17 stress-ng-cpu [run]
> >    555 arighi      20   0  R   1 100.0  0.0  0:28.67 yes
> > 
> > It's debatable whether per-CPU tasks should be re-enqueued as well, but
> > doing so is probably safer: the scheduler can recognize re-enqueued
> > tasks through the %SCX_ENQ_REENQ flag, reassess their placement, and
> > either put them back at the head of the local DSQ or let another task
> > attempt to take the CPU.
> > 
> > This also prevents giving per-CPU tasks an implicit priority boost,
> > which would otherwise make them more likely to reclaim CPUs preempted by
> > higher scheduling classes.
> > 
> > Fixes: 97e13ecb02668 ("sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()")
> > Cc: stable@vger.kernel.org # v6.15+
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >   kernel/sched/ext.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 236dce2fc13b4..4c3592e26ee45 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -5726,12 +5726,8 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
> >   		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
> >   		 * the current local DSQ for running tasks and thus are not
> >   		 * visible to the BPF scheduler.
> > -		 *
> > -		 * Also skip re-enqueueing tasks that can only run on this
> > -		 * CPU, as they would just be re-added to the same local
> > -		 * DSQ without any benefit.
> >   		 */
> > -		if (p->migration_pending || is_migration_disabled(p) || p->nr_cpus_allowed == 1)
> > +		if (p->migration_pending)
> >   			continue;
> 
> I think it is okay to keep "p->nr_cpus_allowed == 1" to the
> condition. When a task is pinned to a *single* CPU, there is no
> other place for a scheduler to put the task. Additionally, adding
> the condition is acceptable in your example of the first task
> running on either CPU 0 or 1.

Yeah, I was also conflicted about whether to keep `nr_cpus_allowed == 1` or
not. The main reason I lean toward re-enqueuing all tasks is that some
schedulers may want to re-evaluate other task properties when a CPU is
stolen, even if the target CPU doesn't change.

For instance, a scheduler that adjusts time slices in function of the
amount of waiting tasks may want to re-evaluate the assigned time slice
after a preemption from a higher scheduling class, even if the task is
bound to the same CPU.

There's also the fact that the running task is added back to the head of
the local DSQ on preemption from a higher scheduling class. If it's a
per-CPU task with a long time slice assigned and we don't re-enqueue it, it
may block more critical tasks that have arrived in the meantime.

Overall, I think the re-enqueue cost is small and it keeps the door open
for more flexible policies. What do you think?

Thanks,
-Andrea
