Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8F2D73BD
	for <sched-ext@lists.linux.dev>; Mon, 13 Oct 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384233; cv=fail; b=KSZDL+mSMFMXjqmlPC1GBc+81KLL7lPt8awQGIWYTpxaZfqOZso7QZ4pk+gJQvnSjfRf2pIi4yF0EEaYz356Y2xBNhx7fBz3Pm6rNGYbO5C3eL9CHMxMrnK7NNbKPDlxBDgItZX9Hsnenecna3MRAzPvi9wgeGfllFujukxSKuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384233; c=relaxed/simple;
	bh=ix4154PWNz75Bmxm6VP0ElWtXD5EJ16xYxlh+i5OPBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oi9PjloHGsmAD+hFXUw+3HZFhhWei26n+LOF3MbTBAjkhxzcNw/EqsIrrYNtdvDcA2fK0fKoc/6SN0hNh1XN00f85d1NXkyC9ndL0kUEY28j4BwnntT3ExkZKu8s7iqTIWhyoZcyvapKgNI5IShyV+E0RzzRGzDVA083IuuI9Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SHsDMgBF; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SHsDMgBF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdfMwRhZACdmXd2cVfgC+5KLF76d8zzlNpo+73dNYcZzjI1lhIKLr6eUa+m4CjOeDshtM8HLr5y2ljR9v5En0Y/jShSjuTWLOU4ZEBrFTK2J8Yd3sr2IvI1xr6ouvEuAQTGh7WphNtuqvSHSVbYcOMQ0rtFCZ2zY2BQuiqalCVeZceI6A86nvJJZnuRpp4kUKHKSoyJ+9ipjqaCeR/dfDLl+VsJU65e18iQZSMr7wbnIFU28M5kCAop35FK9cF9ljtsN8HG+rfYTjQxm9gpN0J6LOvJgvC5jTUtXyj+EOGMXSNgsWKrv15qupWXD1LThL8qu/iGEQOWYOQPkuDkQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nujXJRNs+PCl02QBJkOpSysZKn30mlFf2sK+jJpa3h8=;
 b=bHMyQ875Dtnnd3Nrr0GX28yXl0gSUtYprGtdKogUpZC62i/4tjU5EeS+wL6C2R6ahDrnaw9V/BfQQXczxguKtOmu0WR3ae0wZuxLvFHQ/gJPRdtE1CFjDi2c4rgQmf40hthDnPqrkXX7q+B/xOWt3hSqR+q6gtrryH619gYYVdHFta736hkQziVIRZlxOHLZ1DV00EUjrlMDAacuksdRhN5yZVpAksK/FpL9PWuvVYx8WbXwGJuzkBkbmEVoczps7yh4F8AUBfqIqrpva1nE6z6vEx2iGM0hwk5sJoYu0t2FqJVPfs0HWFFzCissSOkWNQVS/Gg54IGhWTv0P6D9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nujXJRNs+PCl02QBJkOpSysZKn30mlFf2sK+jJpa3h8=;
 b=SHsDMgBFCZmY2IDqN+JbqWPJ8D8XRfjL5Rab2u0xj89p07/EqeAnG224+unW4BXhxeiwLPFibX6oz88hXsT1UrJgkwR11G6RC66emCjavh6PZ8pdyvML60kxxSloh1PD5fGJrvGLuRyx3XaGURxaG83e/psT3fy6JSei87JmTxmonbaPqEJVHtsre2vjV/xtmgE2DROEpzpLYNt947c0rF23rZ8uxK16ZJCwtBmJwzuabbKPrpn+gob1/ey4vOVddwzv5LkWXoh6f8qj05oHXXQoydqXFu8pNrXsOg3XGPXGliGuHfBYlhblIVIc0gizXRE/MSV61W4LLvxMv4dczA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 19:37:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 19:37:08 +0000
Date: Mon, 13 Oct 2025 21:37:01 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Exit early on hotplug
 events during attach
Message-ID: <aO1U3WjdQ3HKQqtD@gpd4>
References: <20250904055716.87268-1-arighi@nvidia.com>
 <aO1H4IjG5YnI3cwm@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1H4IjG5YnI3cwm@slm.duckdns.org>
X-ClientProxiedBy: MR1P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b88dd2-7386-478e-efd6-08de0a8fe5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YeB5Ev754eEp7S+TF/iDz3cC6bRpejtMx1Gbq/2vHe2bEayQi6gCkcrG63OY?=
 =?us-ascii?Q?DZ6OGd8Fba8Z7aF82x5oEwX6oTxxzYa1P0jddm6iy4v3z4oyRQt3PKBd2ccj?=
 =?us-ascii?Q?zriurL9OdI5xWNB4hLAUJRL09v598Wh5NVGe14m5Kylo1frT3XmhSu6UhWVF?=
 =?us-ascii?Q?DA/Md+W1qU7qO/8jjadZR0WojtXSA+AnaoThhLpSXmrR7u09X+09V9btMc+n?=
 =?us-ascii?Q?dy94cZZHNgjWL3+vFLjop6QiI20sncmeXhmaEnyu6eCEg4BjPqY5gVprOAR8?=
 =?us-ascii?Q?Mu59VITKaaAqmjvJNcey4Q9lfEVOKZcsC2fByniOzzHqwJ3ele5Q4lMd8IgN?=
 =?us-ascii?Q?M1UlOcUVkHMdI2+Wx++vDXCkTCCl9eBXDDIjl3TV18sQQR1cs4vtptPI/aSv?=
 =?us-ascii?Q?HxRMVwUyzbHei72r7qoXaELVwHFpJVrlUvt1b9ZLOU/at92qGMNh5cOlEA6C?=
 =?us-ascii?Q?ww2d8bUY1Y3PM1b83OxhA7sDkeM0sjeqdSyFVlXQcl18wpoiKZhkTDoPGcGO?=
 =?us-ascii?Q?yoIC0mQ3HHhk2n5YI1GhZbKQH8OeqWP/KS46TecxxMzjnMDEEP0eJD7YWAkA?=
 =?us-ascii?Q?uyOvAaoTt+Zf6pvtdYgeUMFyHPLMWTVGzqPhrvsUxXe8IF5BeVvJPO3es345?=
 =?us-ascii?Q?syhaagQTOgkeCGe++G3SpUL4TMJOgwZVUwyvBWhqMJOTq3aqkLaXrPLELVf1?=
 =?us-ascii?Q?p1jCFXsNME07TQyXEIhfacdVJbXvn8eFfmgQ56pjhA/fMjCwMQUBFPqGAhj8?=
 =?us-ascii?Q?BWJDO8YOpSCmH8a2LWjgBsX7NvL3jMZY86Df5pNwtDXtUcqL+YDJsk823od+?=
 =?us-ascii?Q?0SteHMcK72VQe8cpGnvrJEx2lV4tBDIOlXZ+BNOR9MTdHzrxZS1i8buAQsHZ?=
 =?us-ascii?Q?wQi8AjzhGgjW8TMGT7qzrUJ+2aZOAdkc5I+x1NQCc0RIGAW0PTUWoPI4v9o5?=
 =?us-ascii?Q?3r67jwOowwf8doEfYH1N/5dsVrN5CBpoUYvesSX6Ye2i9RrJpSmJk5/vypE4?=
 =?us-ascii?Q?ceHNQu/oBWBMiDX+0282c6mdWrkavq37fX4b7rkQB9LROthxZJaNN9bu2dVF?=
 =?us-ascii?Q?BBQxSSmiDoeKtsj3mhy8tGZC/xlsusgeyHvGuTjFG5EzQvAqqMel146Bco6U?=
 =?us-ascii?Q?zDy+BSSJUI0AnCKcKOJtFqaMyPIBRfbsmQ6yyEoqJCJZ/OPKYtywQjsZkDPb?=
 =?us-ascii?Q?zeZqqEX5DgFbGET5DVbZLoLWopehkY1he7hiXYq/wf3JFyyBHuNNd7b3CJS8?=
 =?us-ascii?Q?IwihD6Dhqd6vwvTxnzE2bZw5hzDF35U5cxfHYD9k/ZCPkMi5723SiU2hqaoF?=
 =?us-ascii?Q?xIXzj8dz4u2wbB3sOCUGITqqWU/sxoHvl5CfX48eQC2e7x+U6vyujBStXPTq?=
 =?us-ascii?Q?4T9K80FxBgWjxfesmQ71UbC49wESRYMTkBOtJca+MssHgjj/J583ySlMiKcj?=
 =?us-ascii?Q?82cfz8mBgAxevADVJqvhLwbX8Eltng8D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bumMufxDkRgcGYjx0PR62WOeuxd0UQ2lSI/4p8e4hhoH2pID+nSuixj9pRAh?=
 =?us-ascii?Q?PRC135FwLTeWsMoucId5cnJZjm38JgCEkwhkYszHRtM2Q9UPCqMsMx1xZHJd?=
 =?us-ascii?Q?CGk0LiBVMJ05/ycM82YJ8l3/ShoYS4eINy2FzkbgvuNh1grPf/vceKXQUmGT?=
 =?us-ascii?Q?d/n8aP0gz+5hyJ4BhH0eACAzLKzJ4PQyi/9p+QzPoUu0/clOdfPnHqzV59FU?=
 =?us-ascii?Q?K27Rmr6mmmPkZkX1yTTibNPuBZiiFZt+oTv691lqBlL6xX1c9DcU64GI5zmF?=
 =?us-ascii?Q?6bNOd5mgPndix0nf2Bl7DDs7xVA6cgPAOEHsDbC72I2HBaTqvufp6Xt/G9jL?=
 =?us-ascii?Q?+MQkLUwIKl+5LeauFd8ZCWThwLIPZxpisNONNrkZF3pmUYAEQnwWdESVwDIO?=
 =?us-ascii?Q?Ha2+dc3onmkoW0lkUVfT4Vr87f7ZkxmPtDgIh/fxojWwfMeyQuddElo8nBMZ?=
 =?us-ascii?Q?WSJDyGqQSc50md2U9j0h9oMxrLNzPU4yyPdvgDmYuYAcrDasBZyYGIhE8yPt?=
 =?us-ascii?Q?pxY8RhexZj3nqM0758qdNJYyW9W7KmtXqp2oiFDLL5VCZPu34+TPxoBR7HcS?=
 =?us-ascii?Q?OT+6cf7ggZINrUN7dRGUm0AGC3ty9ShYD4b0wRWiDqfwlBzW1ng334rtEpqz?=
 =?us-ascii?Q?6fpkW+3yRj+Zq61ZseioJa3VH/5rJb5sPuZK9NalviZH0AI67FiazetfHio7?=
 =?us-ascii?Q?vHFi6YV/gGvfm4JUqT2ZOM+8HngfoJ1eObo6yd/ZGaZt/ls7CIbqZ1HOtU/W?=
 =?us-ascii?Q?Kbgr1Q6tUpSXFWQNBAjlSLALwrQqhszbF3bRuOebcT1YI4U409MmrN2EWr8M?=
 =?us-ascii?Q?fK0SfgBcdSWDWYkN9iDvY/1/059jk52EzcRwwR3byf8fR2cWEb0D39Mu/3lP?=
 =?us-ascii?Q?ZQQ0IZSAQEe9Dd4nw0QrLCq4u70nO8LMUj3M3JjUKMSRBIHC16dWkwc22GuQ?=
 =?us-ascii?Q?ksHqAu1ha/+vj3RhRaMK6C/pMAslX+TkiDSsVwQAqSISMW/V3vlB2a6Oq9xm?=
 =?us-ascii?Q?RERl44Sm/9Fb08auyjwkOLKFu44qvc4CIkrJU69cf0bhFMjj9nTvy81kel7P?=
 =?us-ascii?Q?ynegnHmVzXpC3YHc6I93cj3fX6x36WzdTu+TTkv7GfNp4nOhnNaLRRoHe/DC?=
 =?us-ascii?Q?No8AdXKcvqfD+iqYjPVZH+0ha+dHHd88GLwciO8IfENSuaNeZRGQ67/tXEe0?=
 =?us-ascii?Q?x0/8DMAxGyoc4zTsVIpcN9Bo01BtvBDLQweUD1W4MgiKBZDt91WhUoxvSRlf?=
 =?us-ascii?Q?YTuJQ8LtPO3PY3RScXBlQV6BE34zSv658u3XHsTmh9vsWYU6zjglqSKCiIVg?=
 =?us-ascii?Q?9NMKvWqWOMa7hIYbo4TDUwCFiINtyy/TlSny+4eBMYNPtyd+xubmkRxTmVED?=
 =?us-ascii?Q?A1P2gjEP4mOkk2XdJ2W7eiygpVolz0E8DDyVBKnqZRf1Xmg0NU9yUg7Bc9xx?=
 =?us-ascii?Q?EP+0l8yg+Y97bp5jFTxJTeEiYD6e+9btB30hjYWugnb9QeAYwXMQJfsjw6HK?=
 =?us-ascii?Q?2wnerep1HM5ESQlbZ1iukjAUGVM55XwRKRkWf6vC8bxdVau0zjphl3USahmX?=
 =?us-ascii?Q?T+3E3sVjORkhCHJTSoLJfrxdgfDkIOYXBEjcj4c5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b88dd2-7386-478e-efd6-08de0a8fe5c8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 19:37:08.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLZ5KBE4MqAHyrw881X4pMidheEX8FqKuTc3OErt1gYIhRtGICT78wcZ1LPBMGcUyGsPFItfinUepdm6T/eAXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250

On Mon, Oct 13, 2025 at 08:41:36AM -1000, Tejun Heo wrote:
> On Thu, Sep 04, 2025 at 07:57:16AM +0200, Andrea Righi wrote:
> > There is no need to complete the entire scx initialization if a
> > scheduler is failing to be attached due to a hotplug event.
> > 
> > Exit early to avoid unnecessary work and simplify the attach flow.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> I applied this to the wrong branch and lost it in the pull request. Applying
> again to for-6.19. Sorry.

Ok, thanks!

-Andrea
