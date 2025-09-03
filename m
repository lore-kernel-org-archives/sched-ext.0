Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C654EEC0
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 21:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935313; cv=fail; b=jLFQlaoCq201hOrcoKS+j3tKSb7O5TeoyFOmcey/t1f/K1pKQ/eoWY6kJGYrFNnlD8+kC52PFB43opMh31bqB18WiK/2FblIjlC2xXvq7U6TlY7a1MZiotvi8RbaGKx5KFwuXHADkAooSqHswymbP2i9FMKBiJ1AFW7cla7kp50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935313; c=relaxed/simple;
	bh=0RAszZraO8nLXyj5KhLa0X53lUjx3Toy/bSovUBZFOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y56ZAQNsDd2T1KcY5ptnYI5WqtXbUeH4POCpVyrqBNuitAwP7CBV/cpwHYgqej3vREp+tLoD2DNr+EQ4p4sXoKsc+TApsBFfJM5lyr5ncDud4kr/UttHvjINxK/jabKh2jYaN+ImZi2+etZfH1BavU+KlxOCRzp3+NylfkBk09s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a5fbtSK/; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a5fbtSK/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMydYtkXH1xlKj9lZmp2zyfTIpe2AK3ZyZEfEekkss4OxQZdWAmxKxLAhX8dIZC5WFP6ylTj1vyIqxcOr0jLbPUeyupsTli+D4KchrJo3fYhvyOiPoYs3QH7lo9Bh9d+3X6svxl4u7aKKpwfJEc2v/OiO55X/T3Y7/aWgR8i9cP8PHhbI3Al3KkcTKo4e+MCysBru77S496My5cHav//sQBKUikWa04dNjT/B5D4vTW3QaHPivza0UFiQ+WL0sXLNDQArQjI5XG+Rp2FZcVzpDW1i7zbzM35kn3yaK3NE5q12gH4XwBzajMTxXcuvuveHqN3stEpxpzf4j5u1xYj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOPGqLX9Q9d1Om7AoQYf6J6rSEj5+KGjmMnJMHw+etw=;
 b=LeT+0L5IlvcKX9OQNdY4oaJ/vkQw5rw/WL+6oK+uERONSyDyymyxqDPtwFN9GoIKhWWDK/tG0Ru/cJ6njvW9h5/qTS9zIJXH87AwN6Kiz+CruhWXW78CA+bdffAADU/BuFNyTRyn1HGj499o9wwj8SEHrL/6/4XrqBtydEGBs1zYVek9LvzwyBnNQEc6yGgsPZtRamw/5TeUqg/Wrn9hmtbdrwKcC+aHFvQVs+vh44nqTAPk5YijJgBvRl8EYhxSCIzJeiPEokZR4zfxn3ctV1ObgrYfKaAfZ2X6Cfe8fBVzaf5Ps6CV4U0MH/ys7dKLuDqfjenQJwLBVdOKUM+cfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOPGqLX9Q9d1Om7AoQYf6J6rSEj5+KGjmMnJMHw+etw=;
 b=a5fbtSK/D0kGeWwkU4BBHAaemF5XKMXb99Q++oc1N2ccWtuZEUQ+ARl2KPxVqcsSNNOef+sOoIO/1qqkF6inJ06HZUL9jwSl7vCLdGi3U/Wnz7Oa3Z09MBOD0xV+X8pBiAWeZXr8B/0LbwoA1Frn7nsfMAediAN8b7gSv1a4gOmNBrBX8qELwW+T9ApQX+UR5HGXKbkyibSWNk0hP7bJ6HpgN77NBXQSBEHWN9KRCM5AHOKuRPvShsC3z2FIDdenIuEuA79kL7Zh2cT3o0of3YU+zneVlGzpz4CjldulE19Oe8JhhZfU1kpwwfDAQSm7htUekBswS8ur1aWJbQuzPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Wed, 3 Sep
 2025 21:35:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 21:35:09 +0000
Date: Wed, 3 Sep 2025 23:35:06 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Use cgroup_lock/unlock()
 to synchronize against cgroup operations
Message-ID: <aLi0irnOyHFXY7Yy@gpd4>
References: <aLeANmpO03QiPgSX@slm.duckdns.org>
 <aLg4SsZHY66n3Vi2@gpd4>
 <aLhvUpkanqxNHyZe@slm.duckdns.org>
 <aLipid4JRKEac1bS@gpd4>
 <aLirwysOBpAGubIy@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLirwysOBpAGubIy@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d74caa6-d3c9-4346-e6f3-08ddeb31c1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Sl8vBMydFRWYyssnTTzWZ8Yw+vPtur6pm9YF6p6nIQAr7/JzMm+iDfn856Z?=
 =?us-ascii?Q?XVE6yYueJMaYl2nZUPVszCvYKJxi6ZE4OYyjTbl6hQTr8oJqPTfq0241MOzf?=
 =?us-ascii?Q?V+feYfxvR5DNsZ3rRX3egVCjmNySGzmdHAbkblO/0mNt/BR6xKvCDSAIjbqS?=
 =?us-ascii?Q?mAaLiwlsNHQaAkfV0JbyJ6zfKvJQWEbfclGjSq3+2KuGi0Q0DuynJf6zS1mI?=
 =?us-ascii?Q?Chvtv7qdNK2AiAUKCBtguzBAPn5GCOTzvMmtTr+65PbJhSi0U0WZaJUNB7yn?=
 =?us-ascii?Q?NOj84x1O6rZOKQQxaDqHgzdIiWiw6NTYnIVh6JLWsuas/+ATeMl/hbp4bWDO?=
 =?us-ascii?Q?3G2ZApSUggUFkxjAnvm+TqJEcFuUDBXgtKHRyqhuQSw9Ynx4ovXLwbJjT3nF?=
 =?us-ascii?Q?tZf86UC+LhFhFbioeQLBwv77vzcvwhwaw3H3RfeA3GJxAv1l+EUCQIJe14OS?=
 =?us-ascii?Q?gMCsLx4D4GPfkxlHxdSspQ8APEXIbOyhvw/Q80PYITWm6LO+TgjJQJ/+LLC9?=
 =?us-ascii?Q?intH8mmnoFR3IM62D9FFa+VmmEf7bqMpIxfcUsF4D7QxgfzK0E3iBeBvRMWQ?=
 =?us-ascii?Q?esATOnHEYJrU/fv67w/S0v4dUYdSKpMumFj5VR967m28KZYonvx0D6uuUjDN?=
 =?us-ascii?Q?k57aK4lHZWQbhB7PbCo/PEPOKoAIdt4Yq+4yCvAC4eqmDHZIA53YPIXBpmKv?=
 =?us-ascii?Q?R22Ht/rUIR5WT2lu3FzCKafBja87Shn6nyGOyZuv58rc/BtFPMDL/7K/OWz6?=
 =?us-ascii?Q?A61Agd/iSR7VKMl7AipkND0t7WU2ev/nDx7em1vNf2bqnMZcmAoJniYoe1pl?=
 =?us-ascii?Q?IXYx6IAW0xhM5hnEIr63WLQe++SFdgcjkMkMQdtL9LZl3ZgUa2psBJrl9Wnu?=
 =?us-ascii?Q?OJLR5oM/UrA4zGPNES8WOcz0XYQndkSjwwkMiESaeOnVjSaN+PdF8aDb2WV+?=
 =?us-ascii?Q?AAgRjKhfKZ55VCI/hzX7zhV9ZLmeT+/vKgtbOQIeuMy+caHplhM5T+y/0uw0?=
 =?us-ascii?Q?m6Iaszru6r88AXqxUqNDhB4U07ZQr0CxndlPJoacicOWANCbe/hd2MUdqWek?=
 =?us-ascii?Q?u7YeR5Pd14pZbvcn4GBXM8qDcHlenlo0wAC/Ba4xypRJyImPubfyVjM6lQcY?=
 =?us-ascii?Q?Hcy2RhvhKvVNWEXWqrl1iuj04jsYAl9iIOiRuaydDAgAYKDTuwjV+66oG9JZ?=
 =?us-ascii?Q?o2QkKGV/cnwPdqY5PmAt/Pjmd/EApYykWYNPdfWBENKjEKEN/bX3G47XZfhw?=
 =?us-ascii?Q?TTWaWwhWFBV8Vh07/w/Qtcs6rOPVQ0iNzg0v2Trhru3rMAHR04triOTMlKPZ?=
 =?us-ascii?Q?MOeRgZSE/KQ/O/lXkFKos/hJjtc9mzpamHDAXbhEPH2yjaiYIGDPdZTQUqAb?=
 =?us-ascii?Q?cwdRCIKGRAC+vazziRDvqcLvwdDthGssqqp3jMn9N+KTAY/WPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+K48XFuiwdEaBfaZeu5mgBr5XPqcX+GXX6hMC6yR+liZpGczzOlKTj8Pawo?=
 =?us-ascii?Q?+NVPAXCm1l+KMAj9HW5s/X7MEeGqzcIJdXtdzYXNERNIlIXrnCGNYGsC/ZQY?=
 =?us-ascii?Q?tusvkfgPLK/X7COE6aK4lzqH5VYPoZ0MEbX9LVWNb92Qzg6MSaidSGFP+R6p?=
 =?us-ascii?Q?NIl9GnflbHBEM9VJwW0G0hyofnEf3mdpwwd9ZXW99+okjFNs6djd5PLcUYKd?=
 =?us-ascii?Q?znzFkQy9s3yYJXm4iakzQAkWEkWcn0aDA+pZ3VmlfS7GoZW+HbErN3c9xV3S?=
 =?us-ascii?Q?dy7Jnnmlh2B2ZvUwlKqzLYSj7aaE+8XsXXj+kVmAdrVdFEnGHgsChq3vKee/?=
 =?us-ascii?Q?YHBxF2Hj28AU3Yr2LoN9/ieUwbv7hUpeDBfXrDQtBP3PWwxwQe5qvVNVhueY?=
 =?us-ascii?Q?3sYr+FyO5KpWN1pLNCmVWTP27uIfIf1QfuA3Y4P3A+OgCgCbU+MbkuRvdgtL?=
 =?us-ascii?Q?Waw1fz1XH5IeDZAF68fH/eZuefNWD4aomutDG8CpqEPkdOTsllpIGhFQd2iK?=
 =?us-ascii?Q?KPyuMHwC2mKjQPD9ImgdJlcWjL7HMc2OkdGQJjg+f+FkBv6yeUS9PB7glBBf?=
 =?us-ascii?Q?WgsNZKqIz8GP9TB5KZqFV0HSM3/5VhWw/iq4M6iRfCgrUFD24TerSilsitrG?=
 =?us-ascii?Q?rINMfmQme7mVlkIhIzxk4wyWTZ3BoYQhs53OkO7nJ7L5wiaxkNo0uVsGbNBH?=
 =?us-ascii?Q?74n2o9VB5fyh2NgdTQc1uHu/jARkmJjekRwJqgtjkwo5y2x9KBZQIl/3phx+?=
 =?us-ascii?Q?MrowTPIDUS0Xr3vleWk7wsml5EOuNreQvuWBoNXLmTjRy/tzpwxfIC1kWe0W?=
 =?us-ascii?Q?RQiffk2nrqwWD+Al2DKy1gfGe1DNavKKJKfDnV+glo9X3yEz12XDLC0z/nRM?=
 =?us-ascii?Q?zuIx9y75VThUDH29oin/WS8fob5NThC1VoPscBzk/hCTkiLE/Ies8CO8xCxq?=
 =?us-ascii?Q?sa6+cSPdOPYqdsfKF1ZI74pULnFq26oqW5rsRwJnCOJIVuKROHE3uoT1W6pA?=
 =?us-ascii?Q?uY7wE4ikDPDeZS6bqB4uPbFS8qjvNns/dWlBrG1oC++DXUxLgssovyDHWtpv?=
 =?us-ascii?Q?4PLp4s/Bq8yewfW5gbejpYDH8UDfybBMa8puYH3uDNjSNy2tqh7TxeOvKUfH?=
 =?us-ascii?Q?S12mxaK6OctLEFtQ6nu6mPGY4mky7QzZNr2OHgcR9IezcmBXLbIQda6Y9ALu?=
 =?us-ascii?Q?oopy6Uc2w8YdufERrP75PYI4e9Q0I2XT3DK7r7cMwRYUWR5s251oeIwyq6ww?=
 =?us-ascii?Q?Yk19fyl+zjNiiMMw0XV5dHx5pkhL6PMa91kK6WSkhohFi+1rAOzUWyJqpnkR?=
 =?us-ascii?Q?XyC+EX3+gMCngaPv7GX8aIB3nPOXpWhpyIvBQ54hgr8EWgEwjYs0mrcedpN+?=
 =?us-ascii?Q?hYHSR5BbK5IsIHXJqD4QelWMvaV9xQQoZNy4d2GmcvFqp1yCz+9O+CMIMasn?=
 =?us-ascii?Q?FqC6c4z7cGCPfIg1NeKD0/IIwTXZRUYVIczxoyq8/fncRz6P5OMeGHR7vkbX?=
 =?us-ascii?Q?OZnKi19V/7UjnAmt46qEdmDop284eOSMIeGwUzfjSs+eqIp830927MWMA/AM?=
 =?us-ascii?Q?7UCs/Wnf1h7ieD9Z6KDwNbL3O4kh45Tsh84/lfm1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d74caa6-d3c9-4346-e6f3-08ddeb31c1c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 21:35:09.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeUCTsAOtgvk+BTDrpCiwiwwX/mIDZDBdmh/o3MYzA8ZEKVdxfxRDuoBL0NuEs3zmtzROBMQlYLHfvQl7ywtEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

On Wed, Sep 03, 2025 at 10:57:39AM -1000, Tejun Heo wrote:
> On Wed, Sep 03, 2025 at 10:48:09PM +0200, Andrea Righi wrote:
> > On Wed, Sep 03, 2025 at 06:39:46AM -1000, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Wed, Sep 03, 2025 at 02:44:58PM +0200, Andrea Righi wrote:
> > > > >  static void scx_cgroup_lock(void)
> > > > >  {
> > > > > -	percpu_down_write(&scx_cgroup_rwsem);
> > > > > +	percpu_down_write(&scx_cgroup_ops_rwsem);
> > > > > +	cgroup_lock();
> > > > >  }
> > > > 
> > > > Shouldn't we acquire cgroup_lock() before scx_cgroup_ops_rwsem to avoid
> > > > a potential AB-BA deadlock?
> > > 
> > > There's no existing ordering between the two locks, so any order should be
> > > safe. The reason why I put it in this particular order is because any
> > > cgroup_lock() holder has no reason to grab ops_rwsem now or in the future
> > > while the opposite direction is still unlikely but theoretically more
> > > possible.
> > 
> > Isn't scx_group_set_weight() called with cgroup_mutex held? In this case
> > the order is cgroup_lock() -> scx_cgroup_ops_rwsem, or am I missing
> > something?
> 
> Oh, no, cgroup_lock() is only held for operations that change the cgroup
> hierarchy - cgroup creation, deletion, controller enable/disable, task
> migration and so on. Writes to control knobs doesn't acquire cgroup_lock().

Ah! That's the part I was missing, thanks for clarifying it. In that case:

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea
