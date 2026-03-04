Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F04536B069
	for <sched-ext@lists.linux.dev>; Wed,  4 Mar 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642616; cv=fail; b=S7ouU+atjMNv0ePVG3LP827EMDnUyifrlsKcjCqytRu32f8CS3NgthZsv8M9fITIYhRzSxEHHjBY/yeW7IdVB4+4UJ1Qwhz68rZahg88MJe59BXtO/y7+OZyxw59YZ9zFiarbPxc7/cFANb7aL3wfZRqXqWDY9gMrxx1bTUA+YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642616; c=relaxed/simple;
	bh=LkW4YSVG7S/5B3MdTpsuqZgsiuueDyHd3wvDiHMRojI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lVJ3FzXMngTqjRNKFC8sUcnpOFtR91LOCN/TJE6MUm4qnlD9h87h4kpQ+JcOItPSDNm5GvJma5bt2jfkRX9AJYRJloloD3ilYaHcVamaT+/nu3g9fSKLUblk6fjclJbnTCVDv8NVJV+lYVYHq4HJc7I/Z2UbfpmBGpvUJ5r0oCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IVDy/q4Y; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IVDy/q4Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giKJ7kXc8C5hQsEzycTiZpkB5jeikOAh/z1azmnEabfzcOQaB4aDwlKMue6pB83ER3UDUCB8WWO7CbicmMXlf1C4QcJVqqwW6dPpOHk9lGOf6zbvRUXnri8i4thOPCiAmoEl/fuzUOmn6jPi/VdR+cbN2/SX6PmsxpKPgLiXzQSKtroAatVU7BbOKLrELAg7CeCCAbyTWpCe6bun1scSYz9bXwaZqKYHfFLZHKzcGOoKlaoYNcTBJT5P/BR9h8F3mTpCUN+59soDhoiaPfX5mGd22cIpDXK7D9765o4/bkrlPF62Ges9pXWGBXN4BHHIE3AtKwdAhNEM6qTy7scCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7LuA+PKJmnC1aw0rbF8sKLL1laqxOTDItzODojZHP4=;
 b=eo/2dFCg/OgjM98j4coBzlTDg7iI77CT87W8y1/ALtHWIInr22/JGl4jHM2L19kli9vegA+4iqt5a+y1upHxlcbrO1IAnP1CuP87Rq5B7wTMPEY3LjdY1q+EytI0tG6Kquea1d+7KdQPUP4Ni3TgCKiOE6RRkIg9jsZxURp3CYXt1q8jPxMSOpbKS/BKWNbAOv0uOsyQRJ+HUmFmpV1RXyDQTqoou7t++XJcl4XshpwpZe76TqclbqB80o8xZSvNc61ycY7XZ9VCvbJa6ghd/cwc8s3tWbsTd+Sa1mLPhdxQhCvibwPUUpbUsHOX+vpKsnDYpR0zC5s/Vvgh/zSMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7LuA+PKJmnC1aw0rbF8sKLL1laqxOTDItzODojZHP4=;
 b=IVDy/q4YjoLxXTVBeT8GTW5BttyFQ3EHyd2Gpgw8MGqq2jNddRNT71mJvqtzGa0ITsuPpCXjGQ6E5NtbX1i759QaIGixt8eK982LbOLl66GCNXgj+3li63Ds6eqq3xcvcdScQfXfc7Nw7u7aYVwzo9i9M8mrkiuDfzc9GLEoUW0B/cOMVs+HOT7izqetmkmNgJZteiZsbGc3uFKEgh9cl4+lOqHluBqhljpl3q7SAX8BRFA1XSER3e71Qpgg34LRP9vdvR1fl1MPpluRb9cnbBAYm+h7yfdISjaeX6oI3fcfdSvlwtmFZ2CrfMO/3IRYsV3spGkTHLdcg5f3+ayP7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 16:43:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 16:43:26 +0000
Date: Wed, 4 Mar 2026 17:43:19 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Document task ownership state machine
Message-ID: <aahhJ9rLDIxA5gzG@gpd4>
References: <20260304153343.340285-1-arighi@nvidia.com>
 <aahcnV2xPabCGc-b@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahcnV2xPabCGc-b@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: dff8ede2-2b75-41aa-9d7a-08de7a0d287e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	t9jwZp9d3QHD32g3xWRJqLSSj9yVPy1KitP3UYR1n5NpZPJ0WaZ26r1vV7I6jF63bYiSrq8tIadUygsIn0Z+ahUeW3Ql3FlKOq3fxT2IymK7Hvxhbw8qqp/SUygmzDGvYkoFx+X0/Z88MwIy8eoqnXB0zhqFeSnLYQ9o0cNcUtCVjPYCW4i7Cubq50pegakwjcjpdDURavrlWxs4cf5cQBZLNXswFR6aZWpPDFZGtNDZ56p0fIkxHUJlozbltwglmOf0cHKUi3lUlYuh0At6JnZxn2gf4+cpfSVhQoGrWfDYAhaAN60zXbqfn9e9VY+5rfoS8tIgvSc9gwYFxn/JpSsP8+CDGz4o1xWbW+fhNEAW2vq27n+e+YJ4x6JYAghd4+/T9msIal1aC+CsEZbjjsDiZ8BfG28joiRiZ2PdJE2TBxgWzYjkpxJNqNd3eWTOfAMIN0mJC09gD9FRZVyGbiPCmcAQL00+lp6RHoD2IiAJnMjyJlqTcCchpVIGPFf7QUtEc8ngaowO8WZe5JHDT6DjNqqG3F1bnRcWNl3uSr/jGlCJYAHnoyf0JYzV4UEdvDgTAoEm16IyZ7KfotDmSEG8rULnK1ExMQsJuIqq0HG3GR4opw07NKNa+ui61WZWPry1cApQjHv7pbw9u8V/Ac5eY0P628htnyKSUoBQOMIRDvfhZ3XQtZhOdQhhZ3iHbMBojIgtKYwFseHjMFDlGG+pJDirgno8gvIqowFGsMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8kkfqRdq81pnIX3REJbPqhmeIWvVDcarGfqqTqzwo3Y3ZN7FAH7YrRQARdpF?=
 =?us-ascii?Q?mjVq+MpkLpR83PgWVkkDvZNl+ry5izQFU5pC8rtGB5V5VoinGZzQQ4wkDacL?=
 =?us-ascii?Q?Q4C10dYNnYtqIUgMNv5+xTNgjUPESTfoLuf1QXA6pBpcbqzbHwZE29ganlXg?=
 =?us-ascii?Q?yNnk5DG+7WMbr1fkNpIPJgf47/57GxacNXAt6tdbFdcoYSpj6i1z3mExx7db?=
 =?us-ascii?Q?xxJiQd8ody8E+Y0fG/Ie208l47Fkp79AhOkxC4oweNYe+Ln6Md5Yvl5vc41H?=
 =?us-ascii?Q?g48iwuTNSzxGwDIQXz5j8E6j3Bg96lSOKLPurfmpU1saCLbBuJTJdSjUZ+v7?=
 =?us-ascii?Q?atkade93fn8OBkgtjhBlKQoQoB+fbNIxmBgb/lrpAwFKlazQgKLRrDHaE1Ox?=
 =?us-ascii?Q?2bTALtn9FhhLd1eJ2D9w22zx9R6flBl5Ii+yaSIpTbWSMQdeyBkmog0Vc5D8?=
 =?us-ascii?Q?lKDzHSQmMg4UhbSRdWyNJ2x1RO2SZ9ynhGDxB42dMmW2Bjdi2N3VbV8BrbNL?=
 =?us-ascii?Q?16/esmosCNfWbrLaVxBT61Wbd52j0cTDX4b4V9N5YeBo1LKF/xJuWF6D6Mp6?=
 =?us-ascii?Q?dE8UK2TxrACFnHScF7N26zAm0dmSKCKGQKt/JxZehrteimGzv5la5W4ZQwbS?=
 =?us-ascii?Q?eRxnci9uP4BPNW3rZoKPMdBve0kUL68/obEpjF31EjIPAWwOmyCwmmaPMd3b?=
 =?us-ascii?Q?Wm3/dw6BZ8Tm5rtjHZ7qc1B8OuwI5putuBS4oAUfeaoEpdR6Xm0MWM7OlSQI?=
 =?us-ascii?Q?ydxYgE5nD7ORjBq6oGQ2aXEKotKsU1J3PHVpapkwSey6wWH6C38szqYohRC5?=
 =?us-ascii?Q?oAwbkQz22wnJYQnRocL2oD6Z0+RDRxkT3QDF9DNGk+6qMzN0/ypEBGxF083Z?=
 =?us-ascii?Q?r0EGUc7n0okE+rkIUJWeldpoj+548zExgIlEHDwOYk39tVrFkXGW9MW2I6RC?=
 =?us-ascii?Q?W2iP75Zm/k670SS5FHiump6K6TU4ajZeU6U16QnloIvIfWLwYMjA2ej5xLpU?=
 =?us-ascii?Q?nrMj1ZVhnjx1NzzjkXZmO20+pn+o6HPvCPGMauWXHRc7VRSdiq6/nA/aIYo9?=
 =?us-ascii?Q?PCIgbQ8Hs2YwPGdoT2SoWU7oK3HshXtFc1X6pVIvBeMhKfOygeVMfQMGVUO2?=
 =?us-ascii?Q?YfIJ4cj4QjajcatHEbKk1GNJyD6oRrdMa3hl4inDRdC4nR7Pea4b9udcC/RO?=
 =?us-ascii?Q?8zGPF8X3a10OcC65u4OM7ZCeuEdVwGZq4pZS/mrdeKxIrfA5mwj6oWnv9/Dr?=
 =?us-ascii?Q?v07IO2pwNAfNQPw1NRCrQpi2h6V9Pggbpc6ykrqq/PLav3tRZsRN/XLZ6dET?=
 =?us-ascii?Q?cvkaksd8wz2fCeRtJ6sUoK4sng8tXJddWLkIPedGdjyZu1FMFv31xAVleNqB?=
 =?us-ascii?Q?bWCDRfPc3DK8oC+nuVvff2VVYlkjsR3xNGRnyG+u0gIyeo0Xteto+ZjnxcME?=
 =?us-ascii?Q?4KA5knQNko+Gd2+hYGZ8TVLv1i9q+di5xCyCH/8Yr75HVZ/eI+Vn6BN+O6tz?=
 =?us-ascii?Q?hGaT/a//GztcqiwSoV5fAzGfVKAHG46Hds8lu0N+8TO7s6jvd88P0i/pYSSZ?=
 =?us-ascii?Q?Gn07L0iWYn2tbdMFz9ataU9NTo3TRH5qtr7emikC7ZjRJB0sVfP7kmsJl3HS?=
 =?us-ascii?Q?gX2fUPh5Cx2FXQROprZV4brcbPdv7N+YTybg137WXoiqQjk90xoLjXmHJ2qr?=
 =?us-ascii?Q?PUKhwUahzu+XRdXp3MBw0DNh7Ry4Xs5asgIeHMlwsisAsF4ijVd4MyAkzse9?=
 =?us-ascii?Q?HoIuS3iObA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff8ede2-2b75-41aa-9d7a-08de7a0d287e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:43:26.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeYzsYnMIcjyDIqD0IfSN2LRVU0dZC2V5xw7J5UrRDr4/sONhTR2cJI5fodZA1nXTb/s4HT9EIn2pQjprPWbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767

On Wed, Mar 04, 2026 at 06:23:57AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 04, 2026 at 04:33:43PM +0100, Andrea Righi wrote:
> > + * Task Ownership State Machine (sched_ext_entity->ops_state)
> >   *
> > + * The sched_ext core uses this state machine to track task ownership
> > + * between the SCX core and the BPF scheduler. This allows the BPF
> > + * scheduler to dispatch tasks without strict ordering requirements, while
> > + * the SCX core safely rejects invalid dispatches.
> >   *
> > + * State Transitions
> >   *
> > + *       .------------> NONE (owned by SCX core)
> > + *       |               |           ^
> > + *       |       enqueue |           | direct dispatch
> > + *       |               v           |
> > + *       |           QUEUEING -------'
> > + *       |               |
> > + *       |       enqueue |
> > + *       |     completes |
> > + *       |               v
> > + *       |            QUEUED (owned by BPF scheduler)
> > + *       |               |           ^
> > + *       |      dispatch |           | affinity changed
> > + *       |               |           | (dispatch aborts)
> > + *       |               v           |
> > + *       |          DISPATCHING -----'
> > + *       |               |
> > + *       |      dispatch |
> > + *       |     completes |
> > + *       `---------------'
> 
> I don't think we transition tasks from DISPATCHING to QUEUED on affinity
> changes. Not yet anyway, right?

Ah, you're right! That transition was part of my invalidation patch, so I
had it in head, but it's not actually in the kernel (yet). :)

I'll remove it.

Thanks,
-Andrea
