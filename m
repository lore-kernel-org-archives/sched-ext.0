Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A642F5A12
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776626669; cv=fail; b=b5f0N3pBFL0BgtkdC53l71lDFP9G8EgOSZSoedSJ5lDbLMG+PFnk2v8x09PN4/qnOKpLAmmml6EjdnsGYAd/+JDmQFMDR1m8OvDIVBXA9lCE6Eyt94gSyXtJOsGs1QID12GM4AAiFXzDjunN9Kq2+77IFR+MhyTV9L3K82cZk3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776626669; c=relaxed/simple;
	bh=a+Y2W4BqiAV+zgvXTynMYOPv1gBK1VIZtcY+vvi66fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aAsH9Xx3veSDqy9Pk1CEtABGB2ULw5PNf3C5kvadn0Xfl8At7/snhXCiY0IGrlfvv5cEb1PhJKEa+/2RwCprfTpR78213Wl/yHUzLdXwS+8fOZm03U/780D66kR3ckuO8Zzz6K8QEVmXDJ4xuP5vCsEwr/gZTMQEN4C0yqPL2+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhBIVtvN; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhBIVtvN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpIJjv3Bi8yyf11bQAupnea3ElA/JlYwya727xEpa3XEiPHsUPAR356bfLQIzxt1tYHwzcbw1EFIuoSj4ycjvmf2zlyHj5vYSjXfT6E9sOSE3hYsjDKebTfXkJBQCQ00Gfh1HMgGFHfd8HCOBQD/zwCDbClMqhgW67DsJYQ4mcTMhnGCDmWSB6fQ0AresKFChuHv6fM8FMsqfKinYRzONz26GeCxnpsUnidNcS4Mhi/suJ5qYZNNojbIsxsrZuKHMQgmJycSgZQTfgWJcX2KLUv4/BWVU72qJ6ldato9vgJncDcuC/kxgpeLn2UjIfB//XzbhIb6vHCHArm9tWKOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3SoysIrO1/uYpYQ6NB6UVndOA2u3NAsfFJ9bQcQDpE=;
 b=lNqhNJksuwD9ZbWrdm3vJ+Ki8MrVTQi55da37hT39irt2/hI4TN4YJalO8KfcRGIK9jNWdBGdD1m9Zr+irBHIoxv5pwXNGmvQ+ZqkZMrhYBorv2xcmUhGjIxbs8LIhJbSnMi+UlUto12MMnngKE2tgMlvJwQ2ZwFRQtXUzQ0ZGR4Rz4SAMzVEs3h83XTwmymCwpSPnMNtPg7Mm4NVZXYRMFL6ZULLuEg4XCvXKAUavLOxQ/n7/kOer0jKWwUsofNPqIsonlCWwoXTFmwkAj1NQOIOy9Dh7i+r5y42Ei5nvhrIi8NFHBxFUuladys8+AOQeFABywGeV5hmd5sDLHXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3SoysIrO1/uYpYQ6NB6UVndOA2u3NAsfFJ9bQcQDpE=;
 b=jhBIVtvNN1negPNtET4OKT+TCDGXShxFkAXIEinR7zLbudAnZr6HgBj6Wqwj7zCiTKrGKM4S4cgpWw9DHNCx6OPQZlwoxkH7e/KRyIL7jBAWT82ikLGxQqC+PMAuVj2Ejl8xcywCPB29URdiLB61rfUUF0p7mwzfcm8duSrrCiaVqcNPMV1kxxYxqMWsY1V+wlrpEfguuK3zJNHGfq22lJtzhDvP5YV/NuY8efxU9xULPiOoAKF09PxQsTLcjHIbht7j0af3NNw4OwZGm4uM6FE+jjADeKG2xdq/t3HNX0vTfoN7yc4sROFAG8qYpgAPJ1JVDcrmbsmpeEnKSiRgtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Sun, 19 Apr
 2026 19:24:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.014; Sun, 19 Apr 2026
 19:24:24 +0000
Date: Sun, 19 Apr 2026 21:24:21 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Message-ID: <aeUr5XCd4c6tcVTE@gpd4>
References: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>
 <aeUms-ccHZhBNVKn@gpd4>
 <aeUpxKBfgvgA1AWO@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeUpxKBfgvgA1AWO@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 900e23bd-f335-481f-7dce-08de9e4943ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/yx3fElxoiMlVlLxxEGmDW/1hf9UhRz8Tmo3S5QAOut8H19E/WFP4q4tDPuzMGK60Y3va/lo0K/iKIzOsHprAiQHo4iH5Iw6kNpk25mjvLRGbNTYaNwjd8RShU33PdH+zcc0cq7GOS9m5PWixgJXvUF2SeeyplbMpbsWSeMMqcQDcJQ90fwtE5jAPolnVjzV3DnQjxFHBF1CD3mtdvrVVx/KhJpw134Kxf3eMWSWmP4lf0TJiQKJmuiGkKTFu1PRHHzsjvgS3dPsaif1/8WvODBPAJSIxZa+FMiNaAKp/uuGMO7toKlCGHoAu8wDq1d4ddctXsuNBQqXnkaNjIn9mWp3hTU9OnnKBO+HowK3LX6iGJFLMMgyeXzuHAFzejcIxadNFwhxOAzb1r/Q1y00m9lOjmm14U0l5qCqdqXW6NpK5i79IrPe4Y2SSEJC4OVr7IUL6TYGV1tCL/CWs1p81qYQeQst5GUGhZNbXbauYk7gCDPXfKTMfIjKbxjFKGyM9WkiltcndEns4ypk+80DFJ7PpzCv5S2T7x+R4/MbIHR7aQIv2f9j7E41+IJoya/9UL9VAo3wRnmZ2R11Lo7/Q6yYCgSZoGz/Q75GxGkybFGIzAUfjQX9871sxfBCPLqi52yj1rKlBBnUS4j3ynklT5Ts3zz456MhVQNmH/tfJ4qujUVL+jJVmb7IQi6Oeq6yzKc3UX/cLCjzcOawKH6W0/xswk7Ou8hh1MVg5JgzsUc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sz+sD8Qd4BH+7ZvE9RvgDzIv0A+BAeHad0awjy+MNKIVtPWflg9HCfJLAW/6?=
 =?us-ascii?Q?7dFhq05YMdVg3CCRlvxmPituRSygYo5DSl35l0EmnUK4EOuAvs3SmpzbCLI5?=
 =?us-ascii?Q?kFMTtaB1qXcEZAcQ+QG5gm4VyP7iS+LoL6tI4Iet8UQSJjkSZ0bWAvq02qhp?=
 =?us-ascii?Q?9RCgcF6xrIAkIMlWSSffzpBayfhmA41T0wjVTgLhPM+z6uFfJUAMnFjRZFld?=
 =?us-ascii?Q?o1f1FD/uCxlTchdr4oP/FPd7G/n9W90eW1xOYcnHofvDdZz5F/RR7hEFqUfA?=
 =?us-ascii?Q?KhO7M/UXU+DrE6KjcvLFLRoBVun/Ytcbn/PGN8W7F8mjS4Z2yvq8JZCDB6VB?=
 =?us-ascii?Q?3YKQJgj/5tL0dEeBm/iCMlrZ0mPoLeHu+D9vViIZjs3/DxBeM53xZz5Aiclp?=
 =?us-ascii?Q?5R31aTwqLqij5kNcHQGjOnRyl6PkN9KG6CBf5IqWKrACR8rylCIKIRuIZzSh?=
 =?us-ascii?Q?RAqHr+KdD/U0TUUiEyW6cnTwmVAvS5koySHIViC+DYF+/Q5zM4AxCNxVcAzo?=
 =?us-ascii?Q?e00Uut9DDhqObr6UfmKYUBgfD8rz7ZNqE57Eli21qA1T4AyVrOLveN/4aX6z?=
 =?us-ascii?Q?t4X61PUjFYSnuQ60YL5yBMYLnd94+U284czi+Ez8XJ9jHqJu3VenJkSrIMW9?=
 =?us-ascii?Q?SlbpIq5gIc+VFstWwjmCGlwJOWK7BNqGvYFlMcTndYScRi0zFIpwem4wF24j?=
 =?us-ascii?Q?niRYmASbqr/dl/LikU6AkX6xFekgR0YPL710yZA4J+8AYIBrsZdriB8oIguP?=
 =?us-ascii?Q?Iwwow4dX4dGiryhl4edL1ljCNuQtsv63CbM14wcyLqF1GeroU8cN8FSYDAPU?=
 =?us-ascii?Q?3AH2tV3IkscDUPc5Z6qP1Scijqw8BK3BJOhuqSIzNTEkQcniyArWQsPBejXr?=
 =?us-ascii?Q?aXOLE1WLVY1f04y/+kQHPgm8g8FELXCVDTP8CffklXktoxpH4VKYca1Bx2qK?=
 =?us-ascii?Q?noPWMvX/hE6E/JmliqL86sv8UgMP65CAIWlM8dQlAjvaXETOTBetJKm8UWym?=
 =?us-ascii?Q?xHFY9lQB6PBytykzf0Y8Lwna179orlfqi5Ui6+OK1f1yrY61xNHB5bhfou5v?=
 =?us-ascii?Q?AVMx2r4nRkJXm1U3PK0irbRkuLPtygAyi4iKsQZQvU4Gi6lIOsGbfhWWEdXk?=
 =?us-ascii?Q?QS5mCGt9+NTuAML+fhMO0nDyXatRqpAwCfMlaQ/jAqHCi4CfeDsCXwFhy+/M?=
 =?us-ascii?Q?mMpAqONSY3JmCJZRUAlQHhR3nUvNyQKyw30XvFaRYuEQqyWDzUIz++KPn/kl?=
 =?us-ascii?Q?wfb43ZftnL9rEftpGEuzD693pwvQbauBRNMNK9vhACYFPbucRZ3iIzLLQpMT?=
 =?us-ascii?Q?91wB8WzLit1CiMWHtwwN56jBaaLrSTS14ayCJ+kDFG5C+0O/K9IpfHMt86UP?=
 =?us-ascii?Q?t7bZs6uQPSnSJ8XMKUm3I3snj5ivAL2ZI3uxCO9A2UfVh/WutQ+/0CDtmki+?=
 =?us-ascii?Q?kK40DLVjBDNqlZLpqXN0/DZtsMlBVizpHDafmhSNFnIYks5hwtNwpTmVF6AS?=
 =?us-ascii?Q?lN2pAUfJxZif5gWC03TE5LQKj1aEh38B76KYG1+KT90bFs712qAGiHRHsERY?=
 =?us-ascii?Q?MoCnnYyY5vBiE4YOU5iHu+Aj3Y5T8+kacJRyHBgw7nKs5cHZw5tTMqlcyt67?=
 =?us-ascii?Q?aI5U/xBG+neq7HlCUIzGkSBq4nLjLW/ckyq00zzkInbLFiCR+wY0/f4h91xm?=
 =?us-ascii?Q?HWorzhJIGn5ugX08zU1WU5LY4GoKOmolslG+SwRYd6rUa92BwW2CiruVJDx5?=
 =?us-ascii?Q?8zS/TwylFw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900e23bd-f335-481f-7dce-08de9e4943ea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 19:24:24.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfQMKxY3yUV2sN1jmAQ4/kBae/m0mApuJor1sNDc6kadyLUGg/YMfCmFSuP6GUZtf2QxdLUBPB1m/rVTNn9niA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

On Sun, Apr 19, 2026 at 09:15:16AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Apr 19, 2026 at 09:02:11PM +0200, Andrea Righi wrote:
> > Hm... WARN_ON_ONCE() only fires once, it can be hard to catch subsequent errors,
> > especially in case of -ENOMEM.
> > 
> > How about triggering WARN_ON_ONCE(ret == -EEXIST), which should be considered a
> > real sched_ext core bug, and use scx_error() for insert failures (ENOMEM).
> > In this way the error is more obvious for the BPF scheduler and can immediately
> > exit if it happens (even if scx_error() is probably a bit of a semantic stretch
> > in this case)?
> 
> It can't fail with ENOMEM with insecure_elasticity set. It should never
> fail. If it ever triggers, it's a bug that we need to fix.

Oh I see, that's related to the other thread about restoring
insecure_elasticity. Ok, then I have no more complain. :)

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
