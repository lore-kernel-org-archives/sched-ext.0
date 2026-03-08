Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5D241103
	for <sched-ext@lists.linux.dev>; Sun,  8 Mar 2026 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772960074; cv=fail; b=D9o8Nl3+7XbzrlJcyKsQcWbZdcV9Y2oiSVN2YO+ghj0Fw81TmB/HIM2bRdG6l2rdyU8dePCRrLmcUBreaHhfmnsM5n1GmxUPmD6GJOrhBQgdXcZMjRfdmPfr5lIDt1XEtLqjLTRy1YAkpPESpWgCoDD8uODYOuHOH4N/v1NQ6A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772960074; c=relaxed/simple;
	bh=2LM95hIEJnxyWFVDqhhPc4NgvmucrYwXHlLcsvMI27Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gBHKAjtKsxHOEdei0Qf1+n/owz0FqbGifqgpvZmatm8Eo+2cHOwGUIHiTpTsc3xVDcLS31dHvwjtoGruOd+W75w2eFkE/+vmjtGrzYRLS5/5VgWXarmklNDqElUfxDfZcLsba5ZLnpaGt/UTD6/TM2kNWWGRoPN7AjhalDYvb3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W0N4YaVL; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0N4YaVL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOwFgfEestWa084z6rRzjESvn5cVjmiAIUthdRxg8uWyfUsO1pF7TxDfPDhu1Lu++hjuLimyux+WZMYuvQme9RXDrDKzxmbg4lgDlR3nRcAXKpmzwnJM9DjvLvTKoWn8DjpCQcB+kqLYaA/FYnqxB8IAN6hHG+qHMyY5RzoWn4F7H/RcjlUL4TaYxn5+k3g5/uVZ9tcjuPTRpfzT1QRymjVT/pcEP98l6gB5vD1OzsE0tH6TvWGPUEm8au0Zh9jSG34s5PSqQYB9uQgxvFRiLt2SwQLm/gv49I53SocbRKRHT6lCM1X0IDGTwOWNHn8deWwfYuEfYJWjVuQasCRZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFMOOsxZn56KMVj5lxxyxd9gMGvy+5fHR23eVEfj0M0=;
 b=umzcHK2bSD2N7GYgTeCDh4zCIHCBHp4qrA/txVIoGybn9QJf/4u2lGAsgA4OkwBHs32qQVukCshdS1pHfy1eFww0M2eDYuMU0/Ve6APPlbj0WqlHR4YI+xYTtCfzFnG+r0/RpYYhzpmVx9CGhOWhT0Xfz9qmthjXPbPm4spWPBX1WbDqyUleDj0VNzRJ8Fkc+MQTOk/dlQ6+wjxOojTd1mUGnkXf/pYisPBg8btIR7AxT2hLAcgReJnDW2LQacECNU0B+M5AGVUrisl8mlnq+PNGZGvRXl0dzblSDTl758dcdoPjYSeJEG9MrlL8aoOTeDt7uBtDsDkZKcM4d8WclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFMOOsxZn56KMVj5lxxyxd9gMGvy+5fHR23eVEfj0M0=;
 b=W0N4YaVLKUpmuRsoDYdP3sbUkPusOy05AaZ0YOXwo1vaWDQYNiMXYEgoPT8cHUsuPAAHeOm97TRjnnwTswauPISon2wNuFbN6qHKdbOzPsFtJ1C9MEA8kK5ULgfn6gfVJyis8lQGR7AfQdIDCjDeMBmXzL1Y8PbpB45z/ondlQNoZSlEJFiUK4PaKd9Y7K2j3X6qn+njh+gSLs0rG/b6hagdf3G+3GWbn2uar3gkFwbJNFeqqHn3Qv+D0lKSj9z+BxKXPCpkBHeyn9e99iuFf44dTi9LYdYGfwSF+l/Y7vdJfS7Ne9Bk2SstT7CfpHRVfMdDIaLb5BWwkvPJ8QvJTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Sun, 8 Mar
 2026 08:54:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Sun, 8 Mar 2026
 08:54:31 +0000
Date: Sun, 8 Mar 2026 09:54:23 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Implement SCX_ENQ_IMMED
Message-ID: <aa05P3RSII3RoGDj@gpd4>
References: <20260307002817.1298341-1-tj@kernel.org>
 <aayofhyFFX9jng1h@gpd4>
 <aazAou_Tak-yGYZI@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aazAou_Tak-yGYZI@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV0PR12MB999091:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b6fc64-82e4-4c58-e1a5-08de7cf0500f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	rGlE7+JZXo3sGbJxb5DUfGYeejZLXvZ/GlA4yOIWwYdiJS65cbzFyoRrzG1rUUfVShqyq0HHGElvKM9nA1kV+JyPQpCKl9zPKlyTcWesOZ7WCf5f+0Rbn/4h4rrt17U+ShIkYWLi1djILfc4QCw4imEH3IiGVW4tAH3LqRVgPulTapdo1S2FT1ucjWMCDmZ5a9wM99j4udYn8KzizvGElBzi5FD/yEvEAMlb/rcCFt0n7sZOCN2KqS3rkwec2JMfD4q0Ot/lUCJUkeMIFZItasHLUN7ma4WpaYIOZXHLLk73ZrT32ExOiEcY+yjKjBZjZ8KXwALyzyccAhD8v7ONJI8laGWsC6sk+Xpp0ghzB02Q7Prgh0oz0L2p4GUSgUGHlnKQmYkY6ffu0u2TalVSbP2UBWr7DdmvRBMzikXhBcqrb3L5xd4EVNstjRlM2+OG0Wserdm60ohGBNNZQL+gBMeHDI6pZ6UN0HlcyPwnWpOido4k5eYrv4b0A1njCHBmEcGpN++LJ45BQn8bTMJysXs/UD7/npapWpml9IFp5exLMwEasd7vZ9TPTalCpBep9tPsI+X3EwlL5UG4qAEzfk2aHVxBBg+4pIKr1j5FcSvC94V/it7zldQDxqiRXZ/20lTPCCjVQcvhEfEY23rB//vsBcPx9if4XMpjt0oJbeHfZzbRqsuKwJNcq3ZTzeG+b2xQS/fHh5QRAR4BLNRHONwjNhwEXvTgMlA1PbUBqLw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5UVKji/+n+52tOug0VmLOjF5vja724Q7JURswHUwAELdlvADy5xpQKrowh9r?=
 =?us-ascii?Q?dR8ResvTVyQ9kNuWhDZmSVL4ZOVgXcCJZzSAEJIJEWyZAzHKFPB9D4PLb3g6?=
 =?us-ascii?Q?YbCVptYKUiVs8b0/cjcG9l3WD4B2pjgDO3Oo2WPMfwF9YIw/NYhIkKCK7mf5?=
 =?us-ascii?Q?Qf7YgaLAYL46eGiYJ30cjzgQrZhZsMdBI8HhO6rzb8wxOltxEXoVSsppV703?=
 =?us-ascii?Q?+puBgqKY16MctqKkSwGL0TkeC7WTJJkaVAJMIJ+1MBDQBg89GZS8ir93DX/8?=
 =?us-ascii?Q?PjaGOYjA57Zp0AVv7czujHrdE4TeasnKxibuIJXCovigzWm+gJGXJoEUS2kd?=
 =?us-ascii?Q?CTUgyzjviXozUsi/g9RrYuafHdHY5Uyo1x5lXaown3Cs1GvjpLa7ALJIxdq0?=
 =?us-ascii?Q?DLcAJ6IMCfAP2mZAkEFzYxOiWlYUGMHt+HFdIiwjfF3dIIERqYuMw1YjSExr?=
 =?us-ascii?Q?oLQJK6dhSofaIQlCYnLfkISV55fowhSAc7psP3i6PbN33wje+yYcYLY1eqIn?=
 =?us-ascii?Q?NfGvIUCkGOpG7Smkh2j9AG1F4P1rj8+gan8nWmeRm2Fwiq7iEBRvaMuFI2bT?=
 =?us-ascii?Q?GpVpznUTnkOVPq4o0l2XpRmz6ZbAhDNhpra98/MfX6yF6kDuWjItg/NQvSc1?=
 =?us-ascii?Q?qv6WV7x64MsrTJOXR4CC/Fan4ToOlbMhWEHojpIPnsOJIqsg9a4rrXsJsdeR?=
 =?us-ascii?Q?gYLsYIadRaxWjfUVLi4/E9I3hYBcic+hbmAsbE6qvVaRueLkRmUy5kAnMAuC?=
 =?us-ascii?Q?X+bSAsbVCPI8L8ZGpH4pIDzZhkQb4AGj29EpQStlzV8QbQC/m1Sx2HElIAzX?=
 =?us-ascii?Q?pHCQqdg88Rk56GcNsN38qnP4jQhVZssL6+vfWWRJAGzRpUvAlyVBrkFT/8Ty?=
 =?us-ascii?Q?BHvT60bp0fedZHgncvU+xi1Gz0p06q/LNUyJ5nx68kANgD1db4cNqZzRMSj+?=
 =?us-ascii?Q?LuQw0snXg82sghMx8cckOO3l/0BUVx0fS21Sf+0kGmammOwKlZ0hYSaYAj9u?=
 =?us-ascii?Q?TYE8dTT1LUmQVeQxBntDGKr+qNzdu+H+ushnBEvkPgIMlKtma5Z2rEepV2yZ?=
 =?us-ascii?Q?pn4QPu3EtjAuO84n/grgwCCg1fSxKJykvh/1dQxk20wo6VRrIxImoiq0GOeM?=
 =?us-ascii?Q?enNK+OtUZVWjKReqlRHdiB9fsXZdWh5omSIHow5pr5U7kd9cQscaM8gLWbpU?=
 =?us-ascii?Q?AqdpyfyeQTYZJnJgXVY3VioC8/0WcDaPrpBfcljhy0yEh2Sv8gScKm6SV2Yl?=
 =?us-ascii?Q?H0X8kGMsQdSwGMR5HEo2MYqYPLSyaCTZDXsuLCKuOXsnBxI81MtjLOyMZ97n?=
 =?us-ascii?Q?KHj3sm7McIvuE59WgZ/+SR3zU4J7PyxF6Ljq+/pZjADc252lQkC+x/gWYilS?=
 =?us-ascii?Q?UC1VvYozRy9IkQfmmBokoCYtTgGvthSc0FKjFald2CXOVVVQebxyHZrb6+Ac?=
 =?us-ascii?Q?NHiBrsXhBTNFoKayT6MyzY/2CY6Tc9wTBrD3sW3AyShuPfmKxrg9ZKf54b+K?=
 =?us-ascii?Q?sx7nPD0YPjjbpeCkrpmIsqOaMQjQtBgkrl5nN9KA7A0gDZ0i+gOJU/oNCSCx?=
 =?us-ascii?Q?wDk2zupxd3zkbNw9l/gqJPx61GpCDydRyawji51+RM15b7qTH7NTiVOjbmVO?=
 =?us-ascii?Q?0SeepePlQvFHVDBfQ4FQ3za4G69Yf44Z4iziyTrQlBTB6frwKvc8bNVtXqkC?=
 =?us-ascii?Q?BwnHYkD/GeGvL246YYEw8l9GkXPTqhUR/HxQg0gH+PMNH2+wdJvAQ+uOTjRF?=
 =?us-ascii?Q?FTA5Nt3PUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b6fc64-82e4-4c58-e1a5-08de7cf0500f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 08:54:31.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BD74ut83gDDeWdsxPtWyASWliAPtBMF+y+FTVohhSPVe6Orm6UMAeGc95BIUqcIXtL1rpIrWWqWpQ4aQwFkEJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091

On Sat, Mar 07, 2026 at 02:19:46PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Mar 07, 2026 at 11:36:46PM +0100, Andrea Righi wrote:
> > This looks interesting, but I'm trying to understand the typical use case
> > of this feature.
> > 
> > I agree that we need some kernel support to "atomically" determine when a
> > CPU is available (it can't be done fully in BPF). Initially I thought the
> > main target for ENQ_IMMED was to improve latency-sensitive workloads, but
> > this actually hurts latency, due to the additional re-enqueue cost and in
> > this case it might be better to be "less perfect" and not use ENQ_IMMED.
> 
> I don't see how it'd worsen latency. You atomically get the CPU or not. If
> you don't, the only thing you can do is reenqueueing to find an alternate
> cpu if available. If you don't do that, the task would end up waiting for
> the CPU which is now busy doing something else to open up in the local DSQ.

Yeah, I need to do more tests with this. I did a quick test with scx_cosmos
enabling SCX_OPS_ALWAYS_ENQ_IMMED and in ops.enqueue() taking the migration
attempt path (find another idle CPU) when SCX_ENQ_REENQ is set, and I'm
noticing 5-10% regression in avg fps / tail latency.

Maybe that's a too simplistic solution. I think with the global
SCX_OPS_ALWAYS_ENQ_IMMED I may end up skipping some direct dispatches from
ops.select_cpu(), that is probably what is hurting performance in my case,
but it's just a guess, I'll investigate more.

Thanks,
-Andrea
