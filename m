Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C2883F
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001521; cv=fail; b=iYt6uhSs184ZhrYydyg3zRjltaCUiTy2nHge2PkZ1u5V9fETWtBRlnDB4944GPwN2bYQwvVmhY/N6ubViy4MyT410XpCvhSynWzpmfsHOj91ngBpA9IQmGynfgsFcAuCiTgn+Z+eQp7D+k9wEa+Od4LpK57hIndL7BXGxOrD9Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001521; c=relaxed/simple;
	bh=R+afy7ItDC4kw4598MHUA35V6pHHeDQg6hx9qqdIPCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jhwh2TJk8JPO/p6aZhHYYQ0FmtvrhiIKWnUGipP48PJw4wS8Yn05F7MB+tnb6x0WVoH9beQsRPJh8G3bnBdIBtyKHDYlAiYyX/XQZ8jdPBCCEmRMCEzPjNBFdpu3Rqkzt5zkx+OAbsxuCF6iVykLY8RJBWZCOrRrHUxuvemJ6x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qf/8I32a; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qf/8I32a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPszT1H3ADWehYgbJ6ZSF85v9XL626ayBmxUaX+MdZGrqfZPz708W+Fdx2ZPYdDFTmeYn3rYBlf845+CLM7WVAcolHP38a8I0nGpNcJgP/qJNFXNax4acmE5DEBpR2OD4WVy+h9atzld52oYbT2zI5nIkETUu3SRFOYrDRADhk/j2OeRdt6ewBJ9yF2MtVl4TcOPuot5x54tUF0ZwhwlIzWiSp6g9KTqGfp0sZ98dU7k0nsmdGtYcbwGUm4cs3Yf293L7EFArD8nyN0ZifGwine27u6SYyOXwik40VI1JutzA4vVSgtmzgBiouR9xVp/Jy8OLKrJpedR/US/0TdOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd7SjYzwlt/cHcnPcpAOVa2wYLehEXJlvBDXjmHid1Q=;
 b=Q/SzV7W6mb0QHW3BgqpifAhLnTyqcxCVLSnmfMUcS0+8hemql6E54AjMOrUdQP/GOP8qy6PLJjjYgfbhs+ZA+ovWsds/mx48CHq5BkIYbgi3cndWOVT9vkhMYNWiDGL6CmHMtbNfTY6eLXslaDdrhyEJrvY7tiDHwuca8+0GI94gJa2XELlSxCBlB//DpSiKXdjmLROKvmVUWmzqoMC0jg2yAtM0RToRWmJhRJ69bJ5RlTCcO6orERUupZt2KQIACuAgdXYfa+BCuTL5zula0IuAv9t23FGtKeLCS5vaFwgmILqNsFKtUmJS3q/eeVANjHVRfGnMiGM7/iq4brYrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd7SjYzwlt/cHcnPcpAOVa2wYLehEXJlvBDXjmHid1Q=;
 b=qf/8I32aIbJjLhEvlIXLrXC/yGB0tSBMd0Wu5ENwpALmvhScgcnP5Ki4h6LTXixP0362DUNcm4nKri0yw78Nvm3/zLYUtOJ3bsxvy6SZXLnU1kqmw5SJWBYc5PrMBKMF4icWlLtYyk8t9JdmRUzt4YVvDf+x/YmMSbZO+tm51VKkzj3ytDcAC2x0DBffsrvLdaCuX3DEEeto+IkoMcW7jjqPYdaVNG7d8osrEi5DbGudvy0B6NvFMRrDPa56RQW/p0s92f612lFKqHWxQvf0nW20wcrf2qjGmwo+ioUDncHM4OdjlUMStO5VLiVuOOAc7p13iXuzQxU+0h659c9lNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 03:31:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 03:31:54 +0000
Date: Fri, 24 Apr 2026 11:31:49 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, arighi@nvidia.com, 
	mingo@redhat.com, peterz@infradead.org, void@manifault.com, changwoo@igalia.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: sync disable_irq_work in bpf_scx_unreg()
Message-ID: <aerjzptPlD7C4x_c@MWDK4CY14F>
References: <20260422100938.35781-1-icheng@nvidia.com>
 <20260422183307.Gf0f8@cchengyang.duckdns.org>
 <aekEN_dlewzVi-Hq@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aekEN_dlewzVi-Hq@slm.duckdns.org>
X-ClientProxiedBy: TP0P295CA0041.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a6fd5f-c15c-4f12-a8fe-08dea1b207c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A/Y0TR0X2yL7+3Anm3B6+yhgGf8ruCcAtgJybaNnEeRSPDNkQB8c9Te9FqbkhQje+07bcDx7iYOKPGtiyHPpCIVAZ7pcuOCdX5igWYSm5Q9jspXmeipDb/NWR6ywY3NTZ8zlySS5WA3LuMZRbn4Avh0iGg+zLqyPDJdrBwLnyUnsGDcle9c2u45CE61FNK2oRODJW/pZFEStjD5aWwtjpIC/Lm3+jPfALhvULo9Q+9WcGSwcZ/rIlJh2nr3O0BOYlfdl80/qVBT4v76w+3sPHWl+Yg+7Pw4fudoo4E+8eYHya94pLpNXtQZc1w+GFNV6NpHGlSUTcT7XDX/aFzuOZUPg41AnHxuPLPe3tqVNxUp4Veev70A6qlMZvAAwrOTuvKKytulZd3vaN1QBRpAPN8d74X7FKFI6JO7YHLabbyHeHILoMb6mDWHV2Bnuh/etKNOLp7cYRMujVwtcHav84FV0RFSSRSlhvz6CvaSVzZYzfwn87iynDJxvVzKuFYj6IvBrHj278gjL6zpd+GuMZ6VHdgYOasxkMzNlRb+y1PLTAxm/bhJCjYR2qbBUIaGkPaE5qklY2OVUP+bRS+4zVTv0s+Yq19ESFWH+Bt4Ey/e5POa3nvIl5jYQYNQ+KD41vnOq0pIcdvXdn2Zv7KMpJ0GHE1rKD3Qb4R9HnBssJ9dhZR1ZsraXDkAS6yYKlEioakAUXj8nrmulxxtpfUSeLQsCQjJetvjG1Q1F64NrFpM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2Ac0FBf9r6f8x71Cx2BVyKX5nwDrhoMcJmQ0XkcbNZALCFU+3qnHU2afj8m?=
 =?us-ascii?Q?obM5gilnxqMVfyokZb2B1c5OaWQgWOlHD0aQzzdPaDRmdjHlLe9jFt7oHMFC?=
 =?us-ascii?Q?j1v/xp9iw/BBitaNV9mglu4eYLnQEPswfLl4ixO+loP7EJXcqF2H4MtLuak8?=
 =?us-ascii?Q?yNzOPeWrwibMdyolvktZc/COFx/8c9aQg7LkzTPCiy78KEHXp08YAQ5z1iIZ?=
 =?us-ascii?Q?Kzlyuz72A/HaXUp8am2dUKNKS1g55Gobzr2HZfmLynW72ti4cwVMp009mJ3t?=
 =?us-ascii?Q?Z+OeVczN0v2hkjQORSUqNFVrF/BmbGoMPFEy0Q9Wb5U6fM2aj31dOF0S34vH?=
 =?us-ascii?Q?7trDi0i8aBcSF8U5H5ygL/25Lzotc2dTkRIcPLX0nwHYKA7DMCbSwGhk/ijz?=
 =?us-ascii?Q?9ps7o/kJIqXkEXV8ABQwbJk11xFH72EDwpvRwNs1eYTtnLeNQhVOtwceGGME?=
 =?us-ascii?Q?ktObEb2NMCmR1420/9CUnxyOLyqB2Uam7f1tPyALZ/HrOxs7WLIUSa8Wkc+I?=
 =?us-ascii?Q?G4A3JvqapjGEuieFDaDvONU77ptVv1x7uW9ymCBt/XDdV65HfmyZNwNPmw/J?=
 =?us-ascii?Q?scdegl9h6Ssjj1r3wWSJNpD9FdW3ycZHLrROVQj6qeR/TgBV8/Yxyc0ZyyGA?=
 =?us-ascii?Q?Hi4oZLpORp2xS/OXXQcNaJnFxWAcp/RqcYI6UCksjDqMjh25bfWSFJBm+gAp?=
 =?us-ascii?Q?5JMLl4wmLy36mHWeAC3M7lbjuqNVNDbjzNiGPjsu5naKnuYvzTJrVAAlKOnk?=
 =?us-ascii?Q?e74dtdE/JqLYG2p+qdBk28Fd00Y42N5y1lWjoec8wjbwK7dD3PnElMZlUDz7?=
 =?us-ascii?Q?RwnhGAtQUBP+MBrgbQE1tr8Vvvou3LNdqC/0v1VOguZM41fwNOxOvAZiG4as?=
 =?us-ascii?Q?7jXMMFsDCVKVPpQyaV/1saFq6HdBzyua+0UpSNiWOmzmd2FURnhzRuAiHCM+?=
 =?us-ascii?Q?Ry3tQEMwoUY7nCO8SpQ6p4oNvYXgF6EODfGO/Jg+GvpoPazgjjHzE1zqPRoD?=
 =?us-ascii?Q?KardJTEcYg+ux1/0dEz+6aw2Y7Cyqq5KxqEmHyONrrpfuxC1H0Fg3hCFNBjt?=
 =?us-ascii?Q?idOov2qITwkrSdC9natO1cCP4iOJrIrQNSR4Ry91SRBbyhVcQG5rkxxVoeul?=
 =?us-ascii?Q?iduls/ELoafj5/An725vXOm/id/oE7sZO5ZWSciE39XEAeLU7TMaTYl5sBwR?=
 =?us-ascii?Q?X57LQ1d+iaDDySvU1rpLjrCygVrWPinsxJoKKTIQZA38S4XhtmKiCsYyjJ8B?=
 =?us-ascii?Q?kB3//y9o7yQAkZsc0tJz1DAQ5zdvd/VWueYXD2QzWD3WBuu5DUQcv3b1sa3D?=
 =?us-ascii?Q?Csqe51HOBZ+srusH/bA0zgThCWpU+8sP7nPgGhJq5iKbRJyV1hRBz62YRFa4?=
 =?us-ascii?Q?7mqOf0xusWpx/UefnjPhLYrx2ja+HDXviIOIW3Utca5dNsVUjTZeObtBAax3?=
 =?us-ascii?Q?nV3D37E/HgwGdmLOG32fc3pNJK4/sIBJ842Yxj9Lg2xkYyNyZSG5pL6xv49g?=
 =?us-ascii?Q?pVvybOcEWhUgoRfAF0YrhMA7q9rI8nH9IBE0Z1svINep46pZFjI7RTMRZp62?=
 =?us-ascii?Q?wt4mxWXZZhIX6ngG1ToHoxaJyyRqzSzmo+WcwPOSNU5ie9bJjzFAKH58VJKw?=
 =?us-ascii?Q?HhyEud24FYvBTIMXL4e+9oNRMqDAKdL1seGkXFEcu9vIcLKzYssTfhryJENi?=
 =?us-ascii?Q?KBPL0H/ieCDZmA3y7i3gszqtxLeZhpiwXGYwfm1u7OJGmOAY93ygDY1t1tDv?=
 =?us-ascii?Q?kT3muqet1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a6fd5f-c15c-4f12-a8fe-08dea1b207c5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 03:31:54.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTvS2lr4Vl2yKLikck4x/ZP56FkAuXl9+6UdWZQamp4VWrB3SWTnzPKdOad8iPmt0Qwkv80vQ0EjgtBbiRkfeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765

On Wed, Apr 22, 2026 at 07:24:07AM +0800, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 22, 2026 at 06:51:13PM +0800, Cheng-Yang Chou wrote:
> > Also, scx_root_enable_workfn() has the same pattern in its error path:
> > 
> > 	scx_error(sch, "scx_root_enable() failed (%d)", ret);
> > 	kthread_flush_work(&sch->disable_work);
> 
> Yeah, can you please add a helper - e.g. flush_disable_work() - to package
> sync and flush and use that in both places?

Hello Tejun,

No problem I'll add this part in v2.

> 
> > > +	/*
> > > +	 * sch->disable_work might still not queued, causing kthread_flush_work()
> > > +	 * as a noop. Syncing the irq_work first is required to guarantee the
> > 
> > Perhaps s/noop/no-op/? Though it's just a matter of taste. ^_^
> 
> noop is used widely in the kernel. In general, I don't think we need this
> level of language policing.
> 
> Thanks.
> 
> -- 
> tejun

Thanks.

- Richard
