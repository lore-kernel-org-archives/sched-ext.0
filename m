Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815F35836B
	for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483253; cv=fail; b=aHZlfIR56OGmw1FEYeflAtNlpfxNpExw/v0KeyU+qyQsc8pqjQTfxTkkAHBtJTQ25ndLz3YgGqtUx0G+0/4u+eh9NCijNtF9IvbPYpd8p3CSGmT2+fLPdAFc1T70Cn6oBT8gctmi1Mx5q2FFv+Zc6tQ8wKJ1Nj38hfk+LouOsvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483253; c=relaxed/simple;
	bh=jnhQCjJP/jfLZBDaThxBsmSKJ99bxEpw2kKn2b8Lh3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=myCk2Qn/i7th0Bbb3yzWTpNiiTz7pXbLuyzr2VdvpVa1WEG0DiowuQoeXJXxgVPobEbqNySaprBqYmkU/Nxnc+2a6hPBXk37zqQ8xWghD60hXrOekv7EnJQUslZW60feDt9GTqCzb7j4FsMQb3ebzfhkSav64bLKh//QsqjrPCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/ExEA1S; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/ExEA1S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUNHOVgOXxZMqTlMOtuC1GrGcVr6ZGzI50igQxQfgn6NRFk/NwwG8fTyhqn7o0bRB9MxPZqxGz+IWE9H7CKGTTSpGmMDs6d4ThwvFoO9kf+lTewvUsfWG2Jxj6Q+3kzy7QTo0DY/SkIGyWYWuPoKfupiwkGDClGX4a9Y+HFiCKG8tMSeE8y7cNSVPRZzfKQ1kHbZVe7ZXHm6JEOFlk6TSUgiHy/1izTXC3lGAszSLdUJkk2x0JVWXNgrg4t6W2Q0//tqwXs+ueur1RRxTQpKr392THBmmGBbUdvAwY9Ab7BL60YTQ6twzzTc+WaaOcoRtM697wv6MCNF2QjZI65sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzQxfQ76wxdDHJfSCERJql+eDK98I54kOc8/Wy5/F6E=;
 b=BmI/ozX9WA94QVghqAyXpND1eHAHyX1uoTIGnDSDOqANBjekK2ND/CWEXp9HTkrvF6+LJfPPJwTmdqwLi/ORjPa9hNFGWkdngJ2bgeBHAuLS3CNm+6Peo4Lt40bOTv3IvpPVfoPRT21yR3e+uFpFIUe4i0iNpQdMLd//3m4/mUpRyMKmlkYS1DaPUJkf1IEffXEO/tclWQtHnAdlVApmLM4dAREZYBADl7FMblF2/pjst6PW2WgEYwNKjUXgs+/dVZyPrKYrMfcdx+VIEvPSq237zS22ogXUNW73/GCGIcJck6ZChzhj90NWisCsn81okE9MUc2oSiqXi8sW8+dYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzQxfQ76wxdDHJfSCERJql+eDK98I54kOc8/Wy5/F6E=;
 b=H/ExEA1SK0K3bvyjj45ftLoCckL5dbR3kZw8b1+zkmjLeb5t35TukY3z49c2gBlZRTA5svM/y+nHFI9g5fcwLSZaeBLOrB6zMS/IhgqVApvh/qpbuNCLpzKs/+2SRUE5RCXDhFpjH9VEqA22fOBz+IhsDrsKOXYz0mkVj4UDMsHkVhlwjh2AoUpBNQzUqaKGiDHYYWEaNcmpPPjQq9DUuDr7aoqGyr+piaXdUIYh3wcXrxHRg5tGGzFgieooyLzyECxN0yRFwTOhT7kS4S9lpX6o+fAtlg3cL405yEyUsbXXydcDYNkqcMayy0BzG24CFOHYSTs9pIdWXPYKLornjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Wed, 29 Apr 2026 17:20:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 17:20:47 +0000
Date: Wed, 29 Apr 2026 19:20:37 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH 08/17] sched_ext: Add scx_bpf_cid_override() kfunc
Message-ID: <afI95TVAVQE5GZP6@gpd4>
References: <20260428203545.181052-1-tj@kernel.org>
 <20260428203545.181052-9-tj@kernel.org>
 <afIQmB4H6li6jL4I@gpd4>
 <cfed3836a31231df1b6119d02f77ecb8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfed3836a31231df1b6119d02f77ecb8@kernel.org>
X-ClientProxiedBy: MI3PEPF00004E99.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::449) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7bccef-ff50-4752-5c32-08dea613a6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	U79k4WsKVGLP/KINKvKRKs4qN8Pwsga0EH8S0Pt/epLhA5Edq5lHohushuY8enf1ONEC3LhNOs3LKKDcxDUcAYh+DnalZtEddDfKwo9jfOqHh4yv0juNkOMHmYXRoVxmWhNyrSleivrJRYYEmPfoE48T+vDkPqj3V20KduCiJwTTUIz3vj9sLuecgPpJYLsZdeJoRjp3DpC2/1PNm6g+ruGJ4khpv60+J0YZRU6HNvthM55Ip5C9bJuyZNfquqM80v+tbgvmigznq6IA7uSa33bdbrvKN80/uER6AHHBUwuW+k/IePJeQIodqoigPiNTqy80Yfg8lUxPOlrZhIduMPJ5ml1rs83BaZifZqBCyRgwD8MES+waZRTuRoENA9ZknW8K5er3pJYRBdgoUslHLI07LHlc7MuKLGpP0Kefv9/nWDWiJRm3FEOEMPMLUQpFoideWKb47Y+u78EDCUVvDX5pLWOJdcx07T08d6PDvyjfARhI5gJkE9ey3F14WcdjhGtTKLIlLH/vfcEGRfvqtMWrkkSETJP4MvrhrXMBGtGTZnn5u1XeLoSpypDNxiJy9Dj7s7DhYTGwpThynwaCd8ECzkLeJ2VbynPijdgHYVu9NWwwDmuMjeVVWkYkXCqx+VsfifGLPsOQ9TsIQA2vD1RedsX84qow+pHWCfV8XDh5dCxvkckedsIMWQkx1w7agMTaVVLhFyBRkySUZiw2ioGtai+oPmJtePgOGi7Nwzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ityJpWRfVrMGWhHkRT8xv8XnSALNB/A7EDHfpwSLFGm8ucehj2DvP+3rp/v?=
 =?us-ascii?Q?ZkQO5HWiQigs09Wijpgqb9JXpzZU65/Kh4niAH0kxSHUWNZ7XajFaw9qF8N3?=
 =?us-ascii?Q?VdKKIZQTHLCdDmeQL/Mg3QZAbKmmqQjIc/W+HEactbMEbKE0hZR4y5yqnYe3?=
 =?us-ascii?Q?65rtZfYETT9OBmlFAhG4B8oQMudSt+HPXGwG6rN2ONh5Z0u8ctlf1CDAPQX2?=
 =?us-ascii?Q?F7s8EqV/eh0IP6EosqOtfnn109bhlEAVporXq7/YovQV97A69ATfg5JEHB2d?=
 =?us-ascii?Q?dMBD3X31zcvn8pf9qEfpqgc4k3A3KMx5AawdLvnJ1vkdsGjzs/3GR9p0JVhw?=
 =?us-ascii?Q?TRSP5+An4VMqEqAj3vkAwGlPyWk9ZypngohO5aq9BUN1j/B2aTYo9RxlBgQX?=
 =?us-ascii?Q?3WAs4kiBO4+QyphLG8eUw/WjRMJv0nibK0oLN6V5SQihuoKZjl0V+i/T2AvV?=
 =?us-ascii?Q?V3kB+tTt1vBOguXfgNjPM8ybSzHZGNOgAqbDDTlYNUX9AkWnEHUnS1fz7lGy?=
 =?us-ascii?Q?gFQoEEYS990+h9pHSOUSsrYouYsFfRZWZO7KR8FJdJFeBD7Sr1XDM6PLhv5h?=
 =?us-ascii?Q?RsDauOvssaznuBGhKaKXFYbL5jTmkAbBtHAHPlCU6ODx8cfDQhLGUOwetL2j?=
 =?us-ascii?Q?uK7nuC9DLsuikyCI6RPgNXs3In1b8U+GpyWLElusEz1mMZwbVYpFF2IwkG3p?=
 =?us-ascii?Q?0C9HU5K4+p4q48BuzIBnJUr7SBuRIaSbh33Hn65UvYpoYF1RMfUSEwM0xxcw?=
 =?us-ascii?Q?FgF/AZI4DHFo/KiiCMLO7/1fIpzmkjf+c6xv1K+CegydJXa50Ef00/j4dnmj?=
 =?us-ascii?Q?tMh5869OJgLFt8niCAImmpxrktSAHi/1KW/BJMU/sZLaQSfNpaDgYD9uM0DV?=
 =?us-ascii?Q?BCJv36lvcDb9+Z39KVjyK/Kea16aH4UKSc/qui1R0R6TvIJt/TR5I2gr5OBf?=
 =?us-ascii?Q?0b2eOchhJw5UlI9enXOvddGZRTMyNR+f99jEFF2IJSPOqvSNvjXDb/BMLh9e?=
 =?us-ascii?Q?UcsHl5/13rnK3BpTBjURBSIGNYDMhDZY2gHZKSathJ+032Hcw4h6jNw3J64v?=
 =?us-ascii?Q?XWmqKVi86y3aFq1JTICQDCUyaoHDeqKX5DJWShQpb+MHsnHIufoKEKIhAjXd?=
 =?us-ascii?Q?HkheIV4ZA6As3dCBj++NQNvsF6bS0+YPKz4lTkTsfBzosSOGoLMGeHZPHO7J?=
 =?us-ascii?Q?Mt2M63jELrjwjdRLuKStJLJWKZCcjRtElDK07EddBEOJEUseZh4Vgmv6uzVW?=
 =?us-ascii?Q?aoRwz0RZDOGXkSCWvX+EHwynDq7bozt0MzgLJr/NOw0mSpSB/bP3P88SQ0zZ?=
 =?us-ascii?Q?j7IkBxy9YKtsKKv9WV/vymS6WHp3dEpt8A9qL8mwxdnHZQLJk6Nyl6oDnW4D?=
 =?us-ascii?Q?q3e0cA0WXQ92ovZWn3NVkIyxIIBAW922+DNkv07EaF2QfZRwZHITVFQsyP6I?=
 =?us-ascii?Q?qFBiRHneYygFsvWpr/qFRZ/vdMyb4LyxkNAx0MaeJCKT3IgA/ZDjuTAI8SOi?=
 =?us-ascii?Q?5/ix8aGTI3Xf61T57exWnI5k7m3k8fKoxgJG997jh1UKpIURe0o+nlP9neA5?=
 =?us-ascii?Q?CdeDdORi9HxlvpcLvaHOaZzggsQ+/ZdTLOjIE0+LHDZosVMh2D5gZs+SF3oE?=
 =?us-ascii?Q?RyMZJv01Dm26jDdnc5mE3V63+p/ZUVbhe9iP/Ftgc0jooiMxSwa5xjbshvmB?=
 =?us-ascii?Q?ocBN4e1eo/xQRX1fBmEKiatnWBt3jIfIasBChUo8g8pi0SSLNEz53il1n+Yz?=
 =?us-ascii?Q?XgP21Jy25g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7bccef-ff50-4752-5c32-08dea613a6f2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:20:47.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TSbPQNZx64NElDTssuoMNgS5CCRob2K3lxebE4sSf1bVmrj9IqkJuBHqO5Brnm6AXIpp6XyjnznKVDMiu+Nxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303

On Wed, Apr 29, 2026 at 07:06:46AM -1000, Tejun Heo wrote:
> Hello,
> 
> I don't think we need to gate it. The override clears scx_cid_topo[]
> to SCX_CID_TOPO_NEG, so subsequent scx_bpf_cid_topo() lookups return
> the well-defined "no topo" sentinel. The scheduler that overrode the
> mapping has already opted out of the auto-probed topology.

Ok, makes sense. At the end if a scheduler overrides the topology and then uses
scx_bpf_cid_topo(), it's probably reasonable to return "no topology".

Thanks,
-Andrea
