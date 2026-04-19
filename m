Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A972BF3D7
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616680; cv=fail; b=qa/dLrkGtdafAL56msxuG3HcZAS4IZK+rY3tea7ea4P8Z+ecdIKXkC6RCoF/9wb6XfN/Fsu3eTr0en61l8csFfK8+9a1SajVnXCH0Jmo5jZZ4nUrMp+MWooa9uZXqCiTotQgWt0spTJiNZ4VbTkDEkM2ExX8ef5yB7dmXoUx7+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616680; c=relaxed/simple;
	bh=WdpsMUo7tvdCbllqP7F9u5MTMLXJeqq5cC/stGbYF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fd8YSKHrkBaOBQ9gU5RRNL3zAS/v4wUdETb0z2kiTI60I7RsdVx8zByqJheNb7R2ZwJsgaKIB0LgtrNu2Ot/GMxkF3oAL33Eyx3t4Qoh8s72xJnLrA/nAXz7s+RrW5qwUvmVdDhTUfBsKEhscoPhYfUPdxuiN6BGeLHAErQydQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XAceYotk; arc=fail smtp.client-ip=52.101.56.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XAceYotk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUl8puEhpywAWd40RC2tGiMUdw+AzE9bh9Zsg6NJQsza/t8LkWGnaEofL2eZM++Vsi2TEARLUjWtxPH5TE5ayrB54y7GBSFY1jjzBNUlrUMvgzlX7wXR54kRQtK47jS2ZLvLHBu0Nrr/DIdxDhbDaxhHzpzNP5ZPMm/4BTLhttVmhiWFzAzbAhHwgCFp0+qG1ZTwNJmALQjnM0dQPM0gJR8kPKY4qjpscM7la4Ms869mlM8c19BjdSPgDvuz7BCoIQnO8zKptzOWp1acgr7dlFP0rornl6V17qQ3dVTUVmqv7WJnX8FxYg0LGT9YXx7DP5pbleWAY2ZyGVGZWdujuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3u9hLyMCAwSa/c6N05DkJXtFjIoW74k8HoUGV2vE0s=;
 b=nEd9I22h4Qd8Wm4EYtAeMQnHCdkBKfm/CS65RY5zMp2m/q+TqAE/wl8QHqPcrkpVje9sqYd88f0mnLNvFEdWJnZEY/PVTEdyiOg1B157LyMyT/vTvm3/qyCbA6dlhkQ+E1XgcH1ry61JYtLoPzQrwKoll9VcJSv5Yxazu7Tj07DYTybkhqWpkWCdpmabm5sperLy/IWR2Jvzt2LOlMP0Fxmblnxaq5/2k3PzLPxvuzkBbJFaNh6i5srOBbPmVYPfASsQY2Zlx/RiYlX7QTQnp5XRf4z+hwNQ/KUaGd+NxMp1tO2N7CzqyDkb40eNcI6dXhgxlt+6vQlFPKSFVO+Dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3u9hLyMCAwSa/c6N05DkJXtFjIoW74k8HoUGV2vE0s=;
 b=XAceYotkr99BTRmfd6PXn60jn+UpBV5DOhphk9iEwuebtcp2JeG5hNdWIGlvmBjsJShGvwPO4UxusWAYv2ijebUlN87f81XIxqeVyyXOyy3rTg1y5wnUGMKMyXUVlnQeY+BRdWPEA/jp+4kUSSer1M2P7Hk7IXtGhxzFto4H8/3ol60tHdvbxhChOq6D1rbvDygSal64qENJMO9D71tubg5sQnzFZojkAOm9kIuNOI0XYx14Q+ts49Fi3OFoQyflz5c8wKGFCwhkPc1ZMinoWxhBpCm6afMjqt5hNVLaq2X7DjzSWETEu5HFE492eu7JFNXMZ4CFJjftWDtqao4Iaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Sun, 19 Apr
 2026 16:37:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.014; Sun, 19 Apr 2026
 16:37:55 +0000
Date: Sun, 19 Apr 2026 18:37:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Document the ops compat
 strategy in compat.h/compat.bpf.h
Message-ID: <aeUE2rgxnw_MD26a@gpd4>
References: <75aaaf7a4dd540191bd8550dd181528b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75aaaf7a4dd540191bd8550dd181528b@kernel.org>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e6b33b-a411-4f8d-82ec-08de9e3201d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r9wKUcsG0Bf6bg8aFYL2tJpnI+YIBcuYicE4grd8Hs9VqK4h25SYCumhiTSwEpzo8RbCzo4p7InL+yQFLB2UsXyTNys3DYXz6/GXnzxWx0OUqZnQoPMIOkBw1BTRQjZ32C7unynrBMRxsSaNs2RkZgn3dbWO8SJazBVDTx1fGz43vBDyNJMunzyz2DkMFqSlHHETs4rQIbI9VuxlO8BY6SbSy9LWU6dYYT37M9TQgVaUSKTzGpAlwOriX62zwAK1BbU8sw59u//w+qoc//bThBU5dJeZcdBpF4Y4LvPVKYpUaikA9KImYYa70Qjz+/L1jZDJaAwtq2Uioy47CZ/itJRI5O/nwqnJpEukDJMrKI4CeWvezvsPXz9NsgphuGqjwIcib6t6lRP1fW8ytwA86lgNiXs1RktkPusmikuyRWU88GR2UadpmEnZoTao+Epgy6ViUYnUpIDy4nd1yQz56Rfdnr+xpLG5d4asIV+l/rshdiA8M33uKKVYgB+epV7hDy2XZwNiRoIxXWDkAye1scylMYMLC1QNV8RFVTflI1wx+cvoEJPLllTQXwACllTrZM0nRM0E1w3ivthx327e3Og+9Z/Iem5EfpIh+CMxTfXHgufP4DrkYDt1moWH8YFcJhPgTC6vjnzS7uJJ57nsnb0tF79/QpXBplE3bG1EU3twufXZZo7BNeqsSguyj1Y+n2aPUPtnI0p0OJpqASNXygpalj0+C7F9qksExiRUjebxZf4A1TBtGKE9BXMUdTaS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CypBiBtP2pWiEESOsgt6ejyB9sBSpscxxfs6lzyRzbOHSRa3yB7yNnGbaafv?=
 =?us-ascii?Q?4Wx2NkodKJiyaQyQCbDlBN3rVqtXy3oPL/Qrzk+h2Nu5RYcDY+rDRfAHo/wb?=
 =?us-ascii?Q?zCKdo+IwIhAKKarsdevmoMXWnr7aw4KiZG9+pLqFOKSsSUBOPxXySZQfnCK/?=
 =?us-ascii?Q?1l151VkucVr+ThO6a2l+/qAW13NHQaCM2zSiJbYJ6w4BtqmeW3Zhd3PTRdzv?=
 =?us-ascii?Q?eZcwjPgrut/1mT6OhT1G5ZLMP+wBss1cQS16Zrge8JrFga5Y5o7PpuaZImQM?=
 =?us-ascii?Q?ku+ayAiiSJnb4sc3BCVeOvJUEZs3fqomayqY0KsZAx6qhENX4ZYZz8K57psI?=
 =?us-ascii?Q?rH33as8nQRg2X7K2DHWAbNTEwzGQSIvlBYhhZGLF7QzOlPPidQdZ4q4nNhey?=
 =?us-ascii?Q?XDMbhL2rVh9PrYmZEe/9tPuAturf37/1C0wir8rwX9UJMqPfXxgSzxlexQV+?=
 =?us-ascii?Q?wf5vg7WcnjmdDzudYfjokoC/fCbh+lcV9qI4+hHtqZK/Ed0ggI0/YeoMbGtb?=
 =?us-ascii?Q?JQFXhoeyj+Wzq1DsVzl+3PAh+ipkLGhh3LP6HNqwWMSAOU/gsbInGSgjHQ62?=
 =?us-ascii?Q?w1TvQXE/pIX3xaTr4r5UPRsSm/9eS03xTXmc5i89FARp8lHsypI2mc1H7Q2q?=
 =?us-ascii?Q?UB7tUQIVDt+kL2am3B/0GoRMHBkMF/VYq2q4y2cPOXoXP0rYG2cqR1592sA8?=
 =?us-ascii?Q?b8//mX+Kmwr4XPTXldCUfnhabRC5XPmNr9o0XBKLJ9TgOFC6k0cGte+OuFnt?=
 =?us-ascii?Q?IGbILTOfeCYBO833vPNTPT+ZVh63aB1itDQtSDET9C7I+KI4pLTKHJkackDT?=
 =?us-ascii?Q?4zyw87PQDZ/v33TucN5eR0SAzb+2Sj9G/QVBlLbFobWG+AkO7vtnq7zEQGZo?=
 =?us-ascii?Q?l0QBZO7Kjh6xlRn6e/iITL9sbaZ/SM/t5n05wyt5WrnV271YQSi/rO+G7uBq?=
 =?us-ascii?Q?mWpzbTELPndKyL+bjHQZbJxvoNSfUJojIZhicoXgH27ZwAlWF+GTbmIjt5QK?=
 =?us-ascii?Q?hChkuo5ZuQBYRX7qZemS5b0OUJLw1DFI/ffhOLPHfaGyFKf23SiKU6b+ylGM?=
 =?us-ascii?Q?t+lRbELZJfP59MLyn8hXWwzCZF2hxAp0aHgsjImPfRxRW4j4qL/RLkrkpHfJ?=
 =?us-ascii?Q?ti6/KNidJfvdxDW2IPuKxh/SnudLkL5gWAz/0z5QAzZMfh7zxvxMZfz+aHPY?=
 =?us-ascii?Q?1ljPtHao52vkBlWbeA4F8kvv239McA76lqhMgjthXLaU5XZ6rnLZdLcPwCux?=
 =?us-ascii?Q?+12qhYFf0S7d7I7zQpVLG4A6Ld/m7P/Tcnk0fF7m86qJgGRFIQrvQvIVsbsL?=
 =?us-ascii?Q?JkgXbvwNPbqSleVDKmw9Kszmbgflp4tWYshbzP5osTZWjSZKoR7qBtOjWu8J?=
 =?us-ascii?Q?QhHG4DIlHQdvJY+9so00fT2xZ9gAKqFrRULglhFDVdrjVKeCXjiVx0GkVc31?=
 =?us-ascii?Q?xCkQaRL9z0K6Czd2M8OfeESOef+VRayiZSMz4gYF55OF98vpA347mCX2H2kO?=
 =?us-ascii?Q?/9kiD2hMDirvdHXRlcuFkIRPedOIvQ77SynJ5MYJQ/0e9O+rQuD7uOLrGtAj?=
 =?us-ascii?Q?0sK7gnbvn5F5XFrWV2d7Hn5IFDGgJQuSmVrRJNjz42wSc0+ZDKI47vKTvFHU?=
 =?us-ascii?Q?buCyPj1lSG08qKpNoKyfQdQWKCFTcFjIhH/6Kv59f9mKHFFjvGlO4V0FHYh3?=
 =?us-ascii?Q?oSOCDRTZztd706gIYFXV7FdORsPqa3csdGKbIasObc9jVpVVAvmvWmz8C7zp?=
 =?us-ascii?Q?K0WcWANyFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e6b33b-a411-4f8d-82ec-08de9e3201d9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 16:37:55.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZW4WJ3VOt0OfEo2TYBdEb/A6eIFjG48IrLNizEzlOmrK20XgYoip8E8E7QkL0YBAdV4KKKFNMc3sGnEuMf55w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497

Hi Tejun,

On Sun, Apr 19, 2026 at 06:18:52AM -1000, Tejun Heo wrote:
> The comments around SCX_OPS_DEFINE() and SCX_OPS_OPEN() were vague about
> how backward compatibility actually works. Expand them to describe the two
> mechanisms: load-time BTF fix-up for additive changes, and multi-variant
> struct_ops for incompatible ones.

Thanks for clarifying these comments.

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/include/scx/compat.bpf.h |    6 ++++--
>  tools/sched_ext/include/scx/compat.h     |   23 +++++++++++++++++++----
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -423,8 +423,10 @@ static inline void scx_bpf_dsq_reenq(u64
>  }
>  
>  /*
> - * Define sched_ext_ops. This may be expanded to define multiple variants for
> - * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> + * Define sched_ext_ops. See compat.h::SCX_OPS_OPEN() for how backward
> + * compatibility is handled (this macro can be expanded to emit multiple
> + * variants for incompatible op changes; SCX_OPS_OPEN() handles purely
> + * additive changes at load time).
>   */
>  #define SCX_OPS_DEFINE(__name, ...)						\
>  	SEC(".struct_ops.link")							\
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -149,10 +149,24 @@ static inline long scx_hotplug_seq(void)
>  }
>  
>  /*
> - * struct sched_ext_ops can change over time. If compat.bpf.h::SCX_OPS_DEFINE()
> - * is used to define ops and compat.h::SCX_OPS_LOAD/ATTACH() are used to load
> - * and attach it, backward compatibility is automatically maintained where
> - * reasonable.
> + * Open the sched_ext_ops skeleton.
> + *
> + * struct sched_ext_ops can change over time. Two complementary mechanisms
> + * keep BPF schedulers built against newer headers running on older kernels:
> + *
> + * 1. Load-time fix-up (this macro). For each optional ops callback or field
> + *    added to struct sched_ext_ops, an explicit stanza below probes the
> + *    running kernel's BTF via __COMPAT_struct_has_field() and, if the field
> + *    is missing, clears it in the in-memory struct_ops (with a warning to
> + *    stderr) before load. Handles additive changes - a new stanza must be
> + *    added here for each new optional field.
> + *
> + * 2. Multi-variant struct_ops via compat.bpf.h::SCX_OPS_DEFINE(). That
> + *    macro can be expanded to emit several variants of struct sched_ext_ops,
> + *    and SCX_OPS_LOAD()/ATTACH() can pick the right one based on what the
> + *    kernel supports. Needed when an existing operation has to change
> + *    incompatibly (e.g. a callback signature changes); the load-time
> + *    fix-up above only handles purely additive changes.
>   *
>   * ec7e3b0463e1 ("implement-ops") in https://github.com/sched-ext/sched_ext is
>   * the current minimum required kernel version.
> @@ -225,6 +239,7 @@ static inline void __scx_ops_assoc_prog(
>  }
>  #endif
>  
> +/* See SCX_OPS_OPEN() above for backward-compatibility handling. */
>  #define SCX_OPS_LOAD(__skel, __ops_name, __scx_name, __uei_name) ({		\
>  	struct bpf_program *__prog;						\
>  	UEI_SET_SIZE(__skel, __ops_name, __uei_name);				\
