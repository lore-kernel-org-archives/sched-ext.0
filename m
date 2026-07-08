Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CF3E7BCF
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497558; cv=fail; b=J/3WZZFurp/3rvW93zTun10J7wykIVELo8QZQWnimmjR9HngiH/y2MrvccB8s8yiM549Bo2kHMRJMqnX/iMknSCb7EVFdORkrSJOlfCNAfrEXZgxojc29OguzJgbrelmKz26h10OQLSI3vzUYkl9eRKkyP1nDHEDZicI5NL35Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497558; c=relaxed/simple;
	bh=o4/FSBWMQuHblPryzn1zTgURoIKq8DLCgfVH7OPpR08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gejBUy6Sb5NuC07003gmpXtJrePwG+TOIqWgHsvTFjazRCdy4dOvmpVZjLWzc43PNH9Z5Pirh4sBsfF3QcfxhlwhnYgOJ/Q3oEOHmqEx7B/mhbLhxMGDdfoCfwOCIxrHXRF1AaiTJXMOxYf4E7uaszBqHGW67nRAW1cnpo0fqac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o5fsKK8C; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5fsKK8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJw/sf8YdZ9C1+Yhzi6vY4i4+NsSdDIqy3uzKPT6r7VUzJspV/nSIXXKinN7WeTWv0ZB+QzWm/sXesmKxqBSs01CDHgv9PsP5XrqqVJKH9oWss1sCK6vSd0NnPV4OPXA6+qYux9bV622c3PcjhRJk9jsT9UVkcbKLow5QkBmJJr+a4tYFSi6Ay4caFiDeeeqhmsPDUpgbmrYEFL6cmyjd9zNmZjA9L9tuvNsoLNIDAwKBKpbjj++2RbJfZ6/h+ttHr53DID/I8CyBavz6EOBmFzM65iqrYgMMYxQ2iYN7dsav9q+eBy2mGHc7nMwKb41gpKLl0P5aeNsvi1tF4N9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCDPXYUf2S+TZGn1zw5MMkK7gMf4SgfRRKISXecE2to=;
 b=ihe6wXstQnLuETJWExYlgRgVDuSNIpnE9Oey9e0aRiBkUKXxvc+riLslDQQl9GWWAAVa8woallWmxc78b9q+f0wuBv4Zi+n03CNo6j4doIiXpkVB/HRCvLZlS4BPgGzEYCYuBf7f4HkVaojxBdLYmFxem4aPXEvMeAhpbvKz10yZaE9zzvveafezQId9Mb9zN5Gcy8cci6xVxQlmz8XEI0k3xUHxG6AA/CFQGmIo3Zp8OvKkvcDpV9bo4WcLt7OZMyLmqQGi/jpv9Bpbhpvi6qi1ldkehMnUbgofo1EdzsFQFMZxXOtPXgHHyCv9/993MzqjJ+MRo9vTe7yOATmJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCDPXYUf2S+TZGn1zw5MMkK7gMf4SgfRRKISXecE2to=;
 b=o5fsKK8Czo3CDsccQXFTzJryYRCzOQuoKaZ8jQWWbo1MIbLgextY3KWLGJUom+UmHS8+tUPmQFJz0kgmjdwGcbCsjHIQkG/pcSUiksV/t7GYtUMKfUnDrAR5TbiGb/NMEyc6mgx7822wtqtuxjNwHvqtC7zgZhjZMeFeQMMLmbnooE09BkfRe8gCDgXpv0SXt6TMMokJziPiJN1snY2Fql1Potzm4SgPoOuhh+kOXn0Y4i07SBRTfPZ+jW2AIcJvyq4XMNNgUGz91AkHkz8D41ZnBNImIOLkS0ivCoyUK7oHGMMDSRnbKUoqiDGRiYu2Q9Gzznz/y6dMQAuH5jXB6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 07:59:00 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:59:00 +0000
Date: Wed, 8 Jul 2026 09:58:52 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.2-fixes] sched_ext: Preserve rq
 tracking across local DSQ dispatch
Message-ID: <ak4DPBCwdLb12c-y@gpd4>
References: <20260707173851.153379-1-arighi@nvidia.com>
 <455e701bca66bdecde530d225f4dba0a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455e701bca66bdecde530d225f4dba0a@kernel.org>
X-ClientProxiedBy: ZR0P278CA0164.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::14) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfa0572-7bcf-4845-5afc-08dedcc6c4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	NhniUOxnY6imTAxC3NrL7XsflAS3H6EIl4CrtIg8T2KeUzAN7+Pk+JWVLgZTS8Wj4IreF3+P+OpPSor77xEsYt7b9hZwEWn9S6IMnfefzl2aMZv2a1KmOueC8rDkPY95+NnDXKe8uUbz36UFF9j+B1f6mKYVgULlRXE8qiQoeMqy4/d90CECqDLXEPeahnfBhtim2Nw6O8i3Hs/88ETeEYRZTYaX+xXYBtJ422qCupslAutX4KZ1l/wgHJBVxMALHle62qJH3o2B5kLfI8JGYRErtOKGz7AcRb3BvOuKSDwry5aMoac5EqiIGQ9G8+SE2yaL6Pz9Zm/IiOXUgkUV4zMdJ2ZAHfibfekndrJRusZwVRtUn1AMpo7VwXEI12pqibZEgqTA4rUmEvNKtxWNw5Kueo5Qd1kUMhUJjvosQEAHcUNJk+65wrDX4OJnVQkw8/fZo61+BO5v6qwDgL04JL5eLbNRzI0ZCwFe8CIcDT5W8qaJuVK0wOYY9afXL2ivWOcn2Mh+x0luFkAcL6gnVKPj5MOFpqz/xXtGFvuVYq19QU1zEWarTGAKeU/EDVT/qIMOioyF2Ah8ztBMCDDCYsDsFmcYtVXbnL5/dnSLkxQDxtj+mwkC4GlRKGR8wgb2dbDGjbr7Mc/kdb1ZH+4vxJt+JnStRyR1ot9x8WHiFco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qCU+ZVPE1WEkyfhKtVIxTCZ+QI3I4RjS3bg5nUjSfcRV4YjsrOP5OUlkAhvg?=
 =?us-ascii?Q?xQ0i19uroJd/iB3zkUEYRD6REYM20FBBoz/6VqcvxJNsY42E2FV89T8FmwbT?=
 =?us-ascii?Q?fp5SZ1se40BR4zKm9kY8zfGVsoDW04RAo0dkSMr2ODzc2juZ1BNnrbIZvZxl?=
 =?us-ascii?Q?07O103FOJYy1xaSgE/CFa2CJEmXLH9j9bLaDr6NwWMgZqzWi4IGw632KT7YR?=
 =?us-ascii?Q?KO8z6qyflbHqscYqMVUADSuUTDXBssP/vWt566sCUlm4pUm9CjR5AGmrshgm?=
 =?us-ascii?Q?XQPv9JB9W0z8SXHmnkiz+zl/8GKpWCZMo8oaUMY2eJgouCXpUY8iYf66dn16?=
 =?us-ascii?Q?HDCRJWAXhOSuFsSQAlHb8koQt8DV/02CrOZ6Y8TL2EY4C2mKNo2/c47e1n60?=
 =?us-ascii?Q?PsjTVBQThWgONtnYI7WwV5mVsqiB3zUEWy7SMJ+Fvf7e73Cxxr4pDwlZW0GN?=
 =?us-ascii?Q?+z7HqYXJzm6A2tcrxmpDSy74L32V94bBcxpeGcJ7Ty6ImkPkwtBYSxZyxj/x?=
 =?us-ascii?Q?kMi0hDFwyhMwd9b/llkRJoX3+fpqfYeR5MO5OZ21mQiafdXU5vrfI+cA9FXC?=
 =?us-ascii?Q?XoOJB9RokKlqJMw7jWF5MIbk8eYOaPFXAMJ1FQ6f3ZP7lil5SgvLD63vYvT2?=
 =?us-ascii?Q?KHelf9lBY3OPKp3owZxhNrDW7cHLtn5yBgH9hZbOf6gIn8EclFmQcd3KvDIr?=
 =?us-ascii?Q?AUcdp9Ii/uYcd1jmt7FQ1YuLbclvhLiEAJ6lTX6S0s+ehbZhGLfYR19CGTt7?=
 =?us-ascii?Q?E7Dnw/0tlqUds6jgEyA9lk8suvToar+zaqHY6UNkmS/IlGGd6fZWL5Lg+DoC?=
 =?us-ascii?Q?nhpakNMnbms4vqOB/hXiAMZzWnazdWw1gkQXc+4X22KDDwRVP6Q5EaUST/cA?=
 =?us-ascii?Q?np+zE3da+wLZ8ZVHziCQAZsoRTcqvG0a+S7gEq6QXLoKlHDY4QdSOQVOh2Xt?=
 =?us-ascii?Q?XDvYmeogyucebMppZP4vu5wIzILcgeJUTsJeILo8AsKvN6tP4XQlbBq2EOzW?=
 =?us-ascii?Q?rs0H4UFBmOtTZj5licP+evy0Mz+CkJzvTr3+9Xz6ez299tDG8/ZMOe1dqIP6?=
 =?us-ascii?Q?Jznc7J0DI+kmLUxR43i9QdYlxQCUHzUhDrXvBk4IDNhZFV/YClsMbCtOWIfJ?=
 =?us-ascii?Q?VmDg9SP5icn0DTcZnjbqW0bqYwV0NS1BHcwQDBx2pXwioAMag8Ij+Fs8LZbJ?=
 =?us-ascii?Q?5Nml5tIuGWWv5utLJe7dPkwMYyAsN61mrTf6V6hZJD//LuG69MjQWx2AT2hc?=
 =?us-ascii?Q?nRKAWml3YFZlP1rroIIbuOkGDArXU/c/xEAa6vBeaQzHJc5sK3NjrQKBwzCW?=
 =?us-ascii?Q?KmbzypdkObZf268VC2nfJibrr68ywrYsw7i/J+60/vhrawuqOOrmEGDpm46R?=
 =?us-ascii?Q?8Z2WJALodPwW1TwVOCdMeeVxEoeNnMbb+5sXrzsw64n4/YJ6lh+MVsQUeIto?=
 =?us-ascii?Q?frgmEqqu3Iy5hxubIQZDO0Ij4wIeXESsBGY7z7jTAzI+0XZoWY4hq92gEZEw?=
 =?us-ascii?Q?eEjBswH5wzPeuf18cxqFdFymUZJ1n/bsIZzXWMhUla1sfY2tvwOAbDIun6aQ?=
 =?us-ascii?Q?lFQUcdMhZZzi2HiE0i7phGBm4unKejvul0oXhZKhITEstdQ9j0xeeX71VEem?=
 =?us-ascii?Q?cLvi9FWBCpjgYj5b9G5FQIU4zXhHL718qVBJzu/YzTWJsBBhEEbIRcFSv3tP?=
 =?us-ascii?Q?TkjaldwsVwHSNAyzUZOilp0tgLoWvU0qkfXw6XP0qaMAr5Mze705F8PHu20v?=
 =?us-ascii?Q?3hyFGfPmhw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfa0572-7bcf-4845-5afc-08dedcc6c4d2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:59:00.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2Lph+0euxRQ9kxrcAxpEbbbU8qHJsN4WSJrfdaPCBue4NAh3d3ZmGoSrekdyIEs15vNUnNRNhkahICriKLiqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

Hi Tejun,

On Tue, Jul 07, 2026 at 12:36:34PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> Instead of clearing and restoring the tracking at the function boundaries,
> can you wrap the lock switch itself so scx_locked_rq() follows it? Something
> like:
> 
> 	static void switch_rq_lock(struct rq *from, struct rq *to)
> 	{
> 		bool tracked = scx_locked_rq() == from;
> 
> 		if (tracked)
> 			update_locked_rq(NULL);
> 		raw_spin_rq_unlock(from);
> 		raw_spin_rq_lock(to);
> 		if (tracked)
> 			update_locked_rq(to);
> 	}
> 
> Then use it at the unlock/lock pairs in dispatch_to_local_dsq(),
> move_remote_task_to_local_dsq(), and scx_dsq_move() (the in_balance ones;
> the !in_balance fresh lock stays). That keeps scx_locked_rq() naming the
> actually-held rq the whole time instead of going NULL across the dance, and
> drops the tracked_rq bookkeeping, the WARN_ON_ONCE()s, and the
> in_balance-vs-scx_locked_rq() coupling.

Makes sense, I'll send a v3 shortly with these changes for for-7.2-fixes.

> 
> The == from guard makes it a no-op for the consume path (there it's this_rq,
> not the rq being released), so that stays as-is for now - it's harmless
> today because the deactivate runs under the migration guards. Would be nice
> to bring consume under the same helper on for-7.3 so the tracking is
> faithful everywhere.

Ack, I'll follow up with a separate for-7.3 patch to keep the rq tracking
accurate in the consume path as well.

Thanks,
-Andrea
