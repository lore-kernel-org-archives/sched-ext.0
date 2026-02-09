Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05720407566
	for <sched-ext@lists.linux.dev>; Mon,  9 Feb 2026 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664024; cv=fail; b=hmEheL7fqYciLM0Yr22FiUedJB3L8H2HL9419qoJlndgDo3QLxdZQTlfxnm48MqTb0zljFq3d2FiyO50KPeDr8q++KL8oaHRcu9HwRC3kliFfY225TLRUnRXPsUJkYX9z5d77dbWhjiJUy/2zcMjJokg+xyGtI6X8KQcj5TOSf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664024; c=relaxed/simple;
	bh=OSAsJHI//8rd/cShmf8nxPelJpISyeq8CyBKd0DZXdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jfmkv4KDeA39fU59Lo/+au9O04y8VAW9QjTsaL2qD4hKLcgTWUm80l0yDbJ4ibYwq/0rC9AQ0zNpPAteUkwsuKpx1WKU1fU8iBn5lXpnfbFgh18oMgvGtGv6ysTdkq8dg2YsW3MHx86LpKO4453tu+Xud99cxlmSsiw4eoHzgAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BEzn6TAm; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BEzn6TAm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XngdkK+udaLB75NOxo3Q9gxq9RH1Tp4Tr3DUtJ8dnudT4tYLVQzucNCc3NgKZigRXklDq6X0iT/pqBUwtij/d4qyH9qE4zcue3xZ3GukzrD/U++eXOwfJrkc7aVGFOZyjX5ctzymz0/nPzv1kYyqc5XHyIeck7NpubyjkWyNvCx4yhklZyUiL9A2l5sRQNc+BVNSXSOJuu3FQBPX8Ubp9n3AfMdNBeqjrjDUoRPOXaRVVxCcRTvO7e/+TvJiD+7zGqVFBtbq93zO/Di2qTVbIV//gaCK3JEci4X7bs8N4haN/d3aqgipd4iusJfSrAgEvjxEFq2bo6g9KKCzed+29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2FuHa3Vg03USedMMLEBdEo7RumxkkTOSwj3XXj5GgQ=;
 b=VtjQdnZtZkrQj4VR1Cb/BHsbV6JGoBa3QoJ+PR6ydbYkpUq1v09W3zTVqftn/fknuboVSAtTXTl4HWu45lyR0wT+B9Rzsg0a8l7QZ3tLiz/4B1jWReZIlGU9fJQfA0/geayqBgK0ODkOOktGWrouLmzisMSIaQHz88g/fySqdr184EYpJeyeJaFe7jprmhMLfo7FjOjdHBonQKvazGUB/uHh0OjMlcHEiAWockkBKKsToMQW1nWnJj6gI5WtGKGkxjkM1IlwDLWwvi04XCN9Gh1JAaEARiShByObkPl5oQPGMK/BJ13kXTx2csUkDImQDAnje25QjJXw2TFnMCjexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2FuHa3Vg03USedMMLEBdEo7RumxkkTOSwj3XXj5GgQ=;
 b=BEzn6TAm1R6styvwKldLE9+RhemsOMeFpmaqWVAcx7x+WPPykX8/TY5Y3WFxv8Dul2ToXhKY47rEfd8TpCbI5Z/fi200J7Owpb/CUpAm2siGAIZ6LAfk5Iz6LImV2OlMIWyPp3JpjrznWdWsJzNmYdrtoz+gctBcHKYA669dupoS+NKGjDz58DdHXyI/TtRsa3Xtqx7S4GG1EGCSXB4RC1LjoR8WvhREQw8b8CfhoG/To/4pWNDzJAqkoGExC6+b/m+MSQ00r4BLgFPQ98ll5QttpvnkDAFXbCu1MPFeZRJmB7tZhVbPiTEdHUrSs35Ta+GWjBKNXzwSCLI1wB4pqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 19:06:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:06:59 +0000
Date: Mon, 9 Feb 2026 20:06:55 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYowT16VM-JnU6dJ@gpd4>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-2-arighi@nvidia.com>
 <DG860JW64VVD.31BS2QTEB8XZQ@etsalapatis.com>
 <aYcFOVlJhUU5huNd@gpd4>
 <aYoZUoyKCxk2bYiy@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoZUoyKCxk2bYiy@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 430a3637-ad26-4c2d-f4a7-08de680e669b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W8LiTKvRbf+JfNPiD+F8aWTqbzjr1iwcRwah0G7tVyb9ME6zOMhNiY+HfxQE?=
 =?us-ascii?Q?oBCGLT8RJGOPmuqnpY3y5TNI7wup3R1iscJAKwu/UIN25Kw0oyEoheAooAhV?=
 =?us-ascii?Q?9g/B+3HTspHcLe874O9jk3Po4JfLfwgtAM6rUetyHLBskT7e4+XfoKIX/r3E?=
 =?us-ascii?Q?KyWDgZw9Dw6izNi18mMtrAqp/dd+xKA1c7NhCbdfnlFIvcZFI2jNsl9/FhxN?=
 =?us-ascii?Q?vq17M4Pp2tZYd2zDeAyG6ltgK02wz7FfFnIdwVhnwd3YRFanymCT8I51x3u4?=
 =?us-ascii?Q?2xKAu+PDtZTLwVrWosUPBgLcHl3HNDMiltGTZFAPBDQXD2L/MsYTEKBRiLow?=
 =?us-ascii?Q?cY9RSd5yUOMhDLGM+pBW1RUXzwrZkYNTfeAREYyE3j386ooMO5g8mYBuqp3+?=
 =?us-ascii?Q?Wp7WyynEcHar2mtHC+lGTn7oIcAQ4MLR5TQnRea0jLvSWEXDi6Eemd5PWUUU?=
 =?us-ascii?Q?z5urajZ4hgx6LRfFvMjw0b6UbOwjo7fsNkuKSHWZDFHbY7zSDZi0VvtwcuZS?=
 =?us-ascii?Q?9Dn6evgJZjOAgYgUdgUmaQzEG31XjwQfBmtt0w5V7R7i++5y97BPLHXq3lNp?=
 =?us-ascii?Q?xNqD88tp4gzDN/MQ6r46iQEjuMCW8hBPy8OSQkzvhYiJ2AretA/XAYNdqatU?=
 =?us-ascii?Q?spGh6WxyNA2BGaphHkZOdLxdxY4e0vo6xaxPNo2Zlg+A1K7/tSjTjvd5mIc1?=
 =?us-ascii?Q?0ly2rcSHrok9OaYBIo+0YldJJ3oCTHx+tqvLjCB8kkM1Q0Dt6AVPOIQ11Qco?=
 =?us-ascii?Q?8c/AHO45mr45MTM+hUXq6zLYmhqbgGxHQ4zW6KF4KAaRWbLe5Kyr6x9UxnaI?=
 =?us-ascii?Q?tWRZk0imMNqyg305rXmHD9rSNQv/izWorK65RIhvo3eLk38YTrCar+iyN5+E?=
 =?us-ascii?Q?xsuVYUKGXbqp7wbvoBSQHXaNQ0Qdd9UeHZ4Pw+g3dOrxG47qOy7ufxFTvnVq?=
 =?us-ascii?Q?DrIzBgZ7d73z4yFRAQuUoVvQiOjc0cNf0b7AMLUwFMVeRXSxURAm/IU3P5bA?=
 =?us-ascii?Q?UE+WDpm417OZbWHVZSIneKKsi3rrLgfbIaMJJuNm0Q46ZJg26jC+tw5EPm19?=
 =?us-ascii?Q?zZJMPszNj4aNuXUJ4K/Jpb36IeC44CuuKiwswbzlvMGQJPkFKeddtLZ8qF0v?=
 =?us-ascii?Q?WKNoQEt/di7FP8MBDmU80vZZ8m69KrGLQL/g4S37gIa4+DCcCbaLEKxH2YJh?=
 =?us-ascii?Q?iagAAn8ZAyd2fJ8aFA8g8Esza5gf+LRMCtqG0eacCUpehJsHHyQrViwF7OpR?=
 =?us-ascii?Q?YddEEqvHO7IZe5eAuUoYbIrrr/5sd5BGyY60hJzyxKIZ9pT4Cy4RmDjwvSu3?=
 =?us-ascii?Q?1Gz0mYPqZPXRRmweNDborAvw/bXaVKlY9NgrGbI2PW2Ufa8TMj786TnhpLh3?=
 =?us-ascii?Q?wTLJkNWBR+mzy7D7XZjkQPjvdwQduxajR0SLZgcyrCznLCRFCr0tublwPCPg?=
 =?us-ascii?Q?gbOP4fFhQ78BiDC3PNrnOtXDh5uhlUvU3FQUcZ2tCgM4/xWwHkru1Y9qRzIp?=
 =?us-ascii?Q?wb0FE3wQyhhAF07OiJma+H1paSi+6SwmCUPsBveVqtkOpkG6j59fA+5nsiGN?=
 =?us-ascii?Q?QkJYn1GIc1LGqDcOtNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qRI0h16vbg82decAlCzJLGr6V9iQ8i+E4hgVliHw8UnEtddiU71VbEz4L83E?=
 =?us-ascii?Q?zK1zcthL7Kt9KvwWFrLxGX7LSO2CMht+S30xpQqz2vxW5fiXGEb9tJaOiQWX?=
 =?us-ascii?Q?ryTGmrnnAEOxh5gu+fQ+beHu0nCgeEQ/LAKzkipR+vbg4dHFRgQTJHMvIj1Y?=
 =?us-ascii?Q?nNb46yB0747CeHW4WS8tDMJviQY+xGawbUnLFBzjPAIVC6KJpQeZpk+2INcL?=
 =?us-ascii?Q?cbEsAHJVxnE4adsOMu39y8D1ddACedx7fRtK4/qd5BnjMLPfGMmFhqpd9aY0?=
 =?us-ascii?Q?QpsNYykhrlgu7c5ruIibOp7uGVIhQW0YrrxkJB5bGZ3CE9CuMf923dI1f358?=
 =?us-ascii?Q?d+IMAXSdHc5JhhFm5vF/BSxy+bXvv+K8WCTZ+b5W3wFTp72pTzIqTehEQYzR?=
 =?us-ascii?Q?D8SuD+Tohcoj0pAdKf3cbiB7z6UOpP95A5Gl2xOy7Wg6XnczOdvOWGmY47ec?=
 =?us-ascii?Q?f3PGk1974SiFsbcYxa/0cpBOm21ESVFQrZQ8Fm5AZZLz55pMCUuUa9yUuBhQ?=
 =?us-ascii?Q?R4y+VsTAUbnR85VDiwFSxdk3anVzU1vjDPXd6+jUazRBa8zld4wO4EEs/R6U?=
 =?us-ascii?Q?uMJ/77BAdME67C+lyZrVFYR0EB6pNyjDghyn5qWGeg84n+Ft03AjWman3mk5?=
 =?us-ascii?Q?0+xgknZh3jN3MJqWKe9Cif3PdDJ0i1omoUwzyoG0KDgPomB5WxhRniULhE3v?=
 =?us-ascii?Q?edvKKkHJEe2nV7KycUEOGHRn0bx+fU1CDdqeLCu+H/QpK5gsTf65MuJUA5Rj?=
 =?us-ascii?Q?7QMKg42OM842rN1hvfk74Wo7dyhyb8LdvIOVIE21fxv2DxKk0QPqmY+1urHL?=
 =?us-ascii?Q?AOZZKpPS8xU6lsQcQu7Or4qXN3stFvxgrtXcfXyOo5DfASqWbmE7KWhH0Phg?=
 =?us-ascii?Q?CF70MfOKalNV3r81jo5SELaq1xRe3NLAmhi/JA6SxsvGEsaDTzrMkiOVl+Mb?=
 =?us-ascii?Q?h0bvNXE1gYkqUDTBW/w5R4Z7xShxO3kS5+jr1Lu5svNDcFaJcClXY0c1bFM6?=
 =?us-ascii?Q?mkja0/wWRSNXtb91u3PPkeqUBIkA2jEDVLskqHLzYSsd5+oYD2p2kxZwU4RH?=
 =?us-ascii?Q?o+5rtjwn7zf4V1NM/fQHXgNqXgMBJRNVJODzpGyZtO2SpPsO+DE25G9Zv9KP?=
 =?us-ascii?Q?i2Ml4Wqlftf9R3Zh/kG6SszoIH+WxOJiopkGQd48s9QDrFWdlvnDY7Fnpzhr?=
 =?us-ascii?Q?kzKOSjlG2VrvwjxX1pGX7Xi2YUkiXhroHMbJHxBns/fb5rcp9hXacGTptxLR?=
 =?us-ascii?Q?h0GEmTVmCk8BN9vYWaYMwdTRgtl8cth41PWpdlMTiNWa2BEBX4EkqjOjelA8?=
 =?us-ascii?Q?dteGKmyj+JglvVtof/HHlBJiwTt7PnLZxDiOqk+Gw888x399FZcd8M9zFHRy?=
 =?us-ascii?Q?9cxKMbGndTB7AyTsitCGwZT/FMlK8MW4hGBJzqdvx5K4RS6y/NyttwnyUZlO?=
 =?us-ascii?Q?Be1/Nes1qgYOS7O0wEAvLVDJmBw9DpA2gIWiljsxlqy5lDX3JkBEnwzG6Q17?=
 =?us-ascii?Q?QYGZ+I+wKC5RZFrlqFABECk3fYF6BtHSROJ/LthyvFF/xumed1rWrn8OZMuI?=
 =?us-ascii?Q?V3oma8otclWQ0ENxBimkereyWvxe2e8Ys2+XUnEdpKJO/NO2MC9JsjP1PKIC?=
 =?us-ascii?Q?gk7X2lgYOeUTuURA25msQ/9qHOSafiZX+cINF6IhUalA/eeyHJEo2qHWvL7L?=
 =?us-ascii?Q?cCprF/0G8v6CS9GyYJsjmFhI5+Yq+74MRS2552iEWtJUXjgF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430a3637-ad26-4c2d-f4a7-08de680e669b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:06:59.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhGsUY02eeORF7vQwpTNxJAio44bKoUsEmzgmYSxg5k/c2qnXoarJ54zmBvPuQQWvIv4X+bKEs7GGP3lK66LRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817

On Mon, Feb 09, 2026 at 07:28:50AM -1000, Tejun Heo wrote:
> On Sat, Feb 07, 2026 at 10:26:17AM +0100, Andrea Righi wrote:
> > Hi Emil,
> > 
> > On Fri, Feb 06, 2026 at 03:35:34PM -0500, Emil Tsalapatis wrote:
> > > On Fri Feb 6, 2026 at 8:54 AM EST, Andrea Righi wrote:
> > ...
> > > > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > > > index bcb962d5ee7d8..c48f818eee9b8 100644
> > > > --- a/include/linux/sched/ext.h
> > > > +++ b/include/linux/sched/ext.h
> > > > @@ -84,6 +84,7 @@ struct scx_dispatch_q {
> > > >  /* scx_entity.flags */
> > > >  enum scx_ent_flags {
> > > >  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> > > > +	SCX_TASK_NEED_DEQ	= 1 << 1, /* in BPF custody, needs ops.dequeue() when leaving */
> > > 
> > > Can we make this "SCX_TASK_IN_BPF"? Since we've now defined what it means to be
> > > in BPF custody vs the core scx scheduler (terminal DSQs) this is a more
> > > general property that can be useful to check in the future. An example:
> > > We can now assert that a task's BPF state is consistent with its actual 
> > > kernel state when using BPF-based data structures to manage tasks.
> > 
> > Ack. I like SCX_TASK_IN_BPF and I also like the idea of resuing the flag
> > for other purposes. It can be helpful for debugging as well.
> 
> One problem with the name is that when a task is in the BPF scheduler's
> custody, it can be still be on the kernel side in a DSQ or can be on the BPF
> side on a BPF data structure. This is currently distinguished by SCX_OPSS
> state (queued on the ops side or not). We do say things like "the task is in
> BPF" to note that the task is not on a DSQ but in BPF proper, so I think
> SCX_TASK_IN_BPF can become confusing.
> 
> I don't know what the right name is. When we write it out, we say "in BPF
> sched's custody" where "BPF sched" means the whole SCX scheduler. Maybe just
> SCX_TASK_IN_CUSTODY?

Yeah, I agree that the "task in BPF" concept is a bit too overloaded. I
think SCX_TASK_IN_CUSTODY is clear enough and it doesn't overlap with the
"in BPF" concept. I'll rename the flag to SCX_TASK_IN_CUSTODY.

Thanks,
-Andrea
