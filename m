Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97362749C7
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286042; cv=fail; b=e1joex0WHPy/W4Gko9iy5KkS6V+cN3qSj2+/Up3aMbecylvvhaFqhGkPTrmaKVHvRd3R+CVA4pBxZ7N3FVWRlaVfv8AX/gpe7rtVvV8rkGlOE3RgluOdK7c8H4YNyaL3tje4/k54yawMAiEqw/b3xy2xFLyNweILX2QGnJ5UZVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286042; c=relaxed/simple;
	bh=U+SuvlUTCdnA1VkownWChUCiB7wI+cWLch+otFCluIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=amfZdwt9WtGB8yFPr6DDz3gfg55okRS5I4vSYjrlAIWZgmREUyBIXJrCbkLk+uBeVQwyWBnyQFPCunudmKqFWE0/orYbWquJamYG2gMJMCvAtDXcrncp0NimECoDevHArvPy3hGdsaHb0oryPhtz8tpqXquguG5/qDKI51LQ88w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JSm1nnpm; arc=fail smtp.client-ip=52.101.52.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSm1nnpm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AASppKpe1+PP8NlKCOmJKdL4oS2VBbVNrVEu89pZf71w+gotMXYEfdfbjhZqH0f5L1DtKj5FThw9yHs51WNAwBcK8Ycm4sHQ3MeCULcSMLwyKF2yN760rm04mQzN+6hNWuGM66MFI7MSl7gLvvplzpFl61DyYs5PxJxLjg4OrOTCXQFIO/LWziENeB2hVmm4qIwTQdI7M2a+emBXy6iXcdLCNA9UMFD2NxJwgh2LBNI3+dyzkm80m25oor2zAbeHP3HqmT/JoisYc5qpfm+JwlesstrguFya70uD/Q0PKzK5hA8Uuo4P2Qwa1yg5pkSaeU1eDnKJIKuM860ARjs2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCdJPM41PjPFzaJcaOqElNYaHmQIN6A9NhWhYB5+XkY=;
 b=pfv892rh3+hIYvKRcBTbxxdcHRDJV2uCNYyJWLkBN9l39hq/U2lYiskp8mqZ+JCokJ+XhYsPhiKFy+XQjPw99gVLbG/q1/vAompX84pZYvthpR3ORJGyG2QcUl9ZjwcpD81mD3FAG59MUxX06IGuUeYz0l/KIkeTFzILES1UMskc6a4WYh8KFe53L/r8OpI25aED0uckYtK4nn894ySISfgFQfQIQTOkRYDaTjtgopyJthQnK+rRMIStmq5dSsjYmzwVm8OJJHEwDvZ6Bi78RkGoX3C59g5YY1TPRwOrXZ8e/iET2HNma7nbX/iVr+1uyFvKqHP58FcZE4C2pVM4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCdJPM41PjPFzaJcaOqElNYaHmQIN6A9NhWhYB5+XkY=;
 b=JSm1nnpmDkrFrfzkdmkcKl5v157o3NTVWW+9akOjYCyq01CZgxM02ZdZrrP9Hzn+2Bo5p/ItHxmyOG4gzU3pwd2JiNy5GE4JdY6DZA9bprMjSe0fyyq5X4raB41eWl1t6qacTauhX02Hx14HOyB/qHGMz80SBk8b1daugq/Yy602UOeDB8ZkVT/7ADMtfxTpTBztkxsEXCR3YXu9c2msBM7aIp/V/4LCWUaGAJI3Kr/F1fJXithsmUMEhWzJk15CWBi6g7xHkkklk7xePepnPDn6GiWI/Zoag40NcpsuUuI78qNF7Nltov9c+KmYhBfrEgkIsmC2kEMRxh484tt9YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:33:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:33:57 +0000
Date: Tue, 13 Jan 2026 07:33:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	tj@kernel.org, void@manifault.com
Subject: Re: [PATCH 0/4] tools/sched_ext: Add example C schedulers
Message-ID: <aWXnTUC1kXitcpTw@gpd4>
References: <20260112214131.50236-1-emil@etsalapatis.com>
 <77b165ff-0cc4-44bd-b3ef-9221f8238f20@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b165ff-0cc4-44bd-b3ef-9221f8238f20@igalia.com>
X-ClientProxiedBy: MR1P264CA0205.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 33669ccc-0102-4637-2f41-08de526dba94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bDMQom0LLjkSNxuBTwtkBEsSYJz0/FbqODcvjsQGPPfOchyBWPsZVgLM/9l?=
 =?us-ascii?Q?Y8V6/KBGmo+pkaneTer9gpgirmHM6yVVqamBfuD/pshgVF8XoGObIjdCICsc?=
 =?us-ascii?Q?u0xqCzr84pzAR5NDAejV9MyI3dwnzmPRhn1ZiX7QJMex7R4dFbVEGZPufK3l?=
 =?us-ascii?Q?VOZT8H1/Dq/6oY5o0WW9c/d7v/gxoQwY2fqCh6sK2CdEjBmerjHNN57zAhgS?=
 =?us-ascii?Q?pMjWofJbiVblIu8ck/ZJAQLFB696XzNpwyOsAIiZ7fZfhDIKDAL8HlFyo04U?=
 =?us-ascii?Q?skbVt9K0amAnGKBHDebUfkU5YQL2BAW7o1YgJRlzdddTuCpQnkjocqHCIlW3?=
 =?us-ascii?Q?WVHQbAGPISexWNchz9SeXRIElRZbwJ1r1ciMeWu9jJx1TK1LjI7uEMfnVl0k?=
 =?us-ascii?Q?asfum6CFTpE9IuuiUw3o9zHozPAdgyuPdQOH+QZubUlIxLTa+BIY8l5W3o40?=
 =?us-ascii?Q?sbvbqBZqHwTHHuEkqFX0tPS3IwI4/wZOeZ1GAbl9yh1bijLGcfeqcrAk8JOK?=
 =?us-ascii?Q?G58MeIVkVcuwJ3YXStMKB2pRahm8djeUe7lCo9MIeU91SmGGE+0W/blPguHD?=
 =?us-ascii?Q?F8iglP5Ugi2BoZ4m58jAnKi0o2N86eOfa2RwqgsEF9VwRohmrAHMl7W6EKbR?=
 =?us-ascii?Q?hd4ypgpfxiKGJ/4S4fgPZKVZn6JOFx9OXSpXEN2kUWrT2PXB/OKhNf3FK9Zh?=
 =?us-ascii?Q?KZbIz8aFZf1iYhe13A2zpOZf6XUikixOHTA0NN2ChSnzGL7zbwKHe9ie88fk?=
 =?us-ascii?Q?+UfGETjRCpYY0DS9X31sUtkel6C47bNBA96/aw3Ie7nbJVZPMIM4/JoKMQhs?=
 =?us-ascii?Q?Lu+twv0qa50TLSNQteJwwIW7CaaXfdJJ5Sj8N3ZfIR5a63Bc9xjVBlyburCc?=
 =?us-ascii?Q?9UES+tnq80PNNbjgbQvKedxB0E7iJydRLxpXal60M0mSyU40EJg75oz4F7Wb?=
 =?us-ascii?Q?EJxAPk/Dksz1A8/xu9hFPGi29QZooxRHKC+Ck37746RqHm06fuh4n1Wiezwc?=
 =?us-ascii?Q?tU6b/BpwMo06hFv1bqS+gjsuUOvj0wwuF3KHr7YMv+mohyx6q0pjZMF8m+z/?=
 =?us-ascii?Q?YYoumSmZ/LgSrETOQTfEGhNozDguSJGLQ/ZvelE4u1dU7W6rWWl+YnQH1wa3?=
 =?us-ascii?Q?2PyNAEKiZfKznPl+WYzasOJgtAHZSho7qoJRyckJZzeV4RUny3l+Qs7cZd2Q?=
 =?us-ascii?Q?yL87R2pm5lsYVbbxtezW8qXBAzk+QeaDXt8xUA9Tr4+Gpu2bCMWjspsYNGIU?=
 =?us-ascii?Q?HUGTroqTCz1z5e5to7g8ASC3QUXG1IzzpXnMrBNLyuXTJXM8JX00AEwctECU?=
 =?us-ascii?Q?asww1zUuXoWs0Sz2EICsC2h7bZxI1J48lplqvkt69piNtRqLTl0bGMm5AGq+?=
 =?us-ascii?Q?o+PujpB8atFhJVH8JqDsviVekqC2YiNupUxB3fDPdQpCbW0w3qhGpRsfbg5b?=
 =?us-ascii?Q?soW5fSdvj/tmOVBmvEQTc+w7aTJtazds?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DcdAqqnLXYHkYDnYa4/gWWTUjcg4ro3zap8fYLu1jXQ3ob50TScMF+p1uZxH?=
 =?us-ascii?Q?QnUXlRKzWBJykKDKeKuWfECXbBKFIY8c5DW03ImUW5vIIHFXUHpj8lcUAfc+?=
 =?us-ascii?Q?GKFiWMmhteJWf6yaMNNAM6ecpmVHdjmgNqhn+dSj795uqUReasjrTKsso+Jt?=
 =?us-ascii?Q?zBsRwO/O5dAz/f5rHNtneOJKmDmvJgedRgEwUnCqcYoWR3FWF0gV+vL82xGR?=
 =?us-ascii?Q?R3HXkT6xlzVN83MByVUJ0wTgB7x6NwdxffWzYUo1GyCxBRLsGLH5TXcdzcmh?=
 =?us-ascii?Q?L5n2ylVswitiw4Nnh2X+uIdHL25OiuQYoo093eHDVQrGHaj5PqFHyN5H+m0l?=
 =?us-ascii?Q?q+3vcUOxuOuQiIvazt1+F6ATpafB83eNq/ikaxNbGsfv2fefi0NwP0+zZcx0?=
 =?us-ascii?Q?8Se/ksWCF/yI6pPGvlDE0DUVY4L4XVJlBJxWrhGlKncoVpWUluhyWfhsbyjj?=
 =?us-ascii?Q?PfopGat+A2dSFBbWjssfucr1TDWvoKbt1oEHILy6UpSL8xc2AD4b+dc7DhkT?=
 =?us-ascii?Q?E+r4SOpdeWDFJ21ZFrg5/5P+ujlHu+QdaB0IeJ4m3YrQQn7lPrwA2eViiTvm?=
 =?us-ascii?Q?p6lQ0+SFpyDN9b2lN9+sn8MGvzdCQ/JZ1FEZXnlGk1Xnea8R0AwLpJqTlgZs?=
 =?us-ascii?Q?nCVxM/9Euube6enJ39DDpy3U4u5ZrfTWECu1GLjh3W+nib5xWvPHFcPso9oF?=
 =?us-ascii?Q?ZeQk5Ah2MvrkaT1YwBmAHGIhhr4Tab1fdjgwSdp7NCooR4DskRbQ+8OkDhFr?=
 =?us-ascii?Q?DMNC911XUBQ35Kt31sfqkf71NWCuvrLSmK2R9TaQkxAHfs0R0IpYSWNOxXl3?=
 =?us-ascii?Q?q3A8OBjTtWSGnpcqHkG91gx8nYNAQi6irnOeVXF3Sf6DPMiyp1deI8RIUPNF?=
 =?us-ascii?Q?HTfHx9Ufw7rfyiSIcIvL/PmJ4Anp47zm3fmoTEBTLeFyzScEE/BfVMqWq761?=
 =?us-ascii?Q?JScNVHkC8Ys+PP/5UEnu7FvC1fZBtFTTvwG5+N+KvT7i8R7GYKnmXc8WHroB?=
 =?us-ascii?Q?r2k6t0RAPjIeBLLwSUJNEDldvoDAZPvNppSlVhEcLdD/fZT3P3heHSP0CsNO?=
 =?us-ascii?Q?Upa2JhCoUFtMOalAnxJxD4EjYwDRCksQv/m7JjZkKHBMM6ONw3trswYMm1c5?=
 =?us-ascii?Q?2Qo6daL/SWB1MSRscnP9VPXtjdh7O8glN1knyslfbaWoS4DoueyZvQVqTkGi?=
 =?us-ascii?Q?UAcxeY2P0pOFbu23wiKYyffEMZhyM+je9e1PLaqyiL4ItrQW0ROars/zYlnE?=
 =?us-ascii?Q?v7mUG8xadvKeSpGVNVVX392wFYBRRK8ZlR0LO9BDCWbG6wxzRmVG2JJXliXn?=
 =?us-ascii?Q?E0HPH3RYSuZkjRqZhHg148UMCLNLS5Zx3XY6+yy9ieQYy5Fv0y027v5IHjKY?=
 =?us-ascii?Q?eoPL1K127tfqWPKkWD0Aw0zAanzhvQauDb65VahCi7/mUCi5VbbRpGhDBZdo?=
 =?us-ascii?Q?1sCyk+v4FzRhcAlPvJfx1/vF+49hxDnYCwRsJEDW7UbIlfPxYaepCGjMZfut?=
 =?us-ascii?Q?9zxeZ8sBa3aYa8bUSCAKaCPyKSA02xcf3y6e6mgbGXQERnIOUHKLa85cX9ah?=
 =?us-ascii?Q?O606y6TkkLjrudhpleKo1Jm1RclIzVi7f83J23sgsKgtg9ssjx8Pqsu28blZ?=
 =?us-ascii?Q?OR/7fAIk+uehGvnnBoUn43Q9Lk4KxjINCghobw0LT4B+pvS+Ff2gOGVtdjNo?=
 =?us-ascii?Q?HkHWnNafPJepj6Gyz4N7OjbHRWq5QXWcr0IfVRISicTSpyqvvIv7mBx45wo7?=
 =?us-ascii?Q?z+r/dP7deg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33669ccc-0102-4637-2f41-08de526dba94
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:33:56.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9KZLBjgAY3fbW5ZYjURnIfQM1uZyvpNDjE0dhwcM1FbwWKhl1BLY/ukGcgnbBWZoszskN88d/pRJy0MoT1Mjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606

On Tue, Jan 13, 2026 at 02:57:13PM +0900, Changwoo Min wrote:
> Hi Emil,
> 
> On 1/13/26 6:41 AM, Emil Tsalapatis wrote:
> > Add to the tree several C sched-ext schedulers developed and maintained
> > out-of-tree by the sched-ext project over the years. These schedulers
> > demonstrate sched-ext's feature set and provide a starting point for
> > scheduler development. Place the schedulers together with the existing
> > examples in tools/sched_ext.
> 
> In general, I am okay to include more examples of C schedulers in the
> kernel tree. However, I am doubtful whether it is worth including the
> nest scheduler, as it has been barely maintained in recent times.

+1 on that, even if it's a good example, it's still unmaintained code.
Maybe we should just move it in a separate github repo.

For the rest of the schedulers I'm ok to include them in-tree (still under
the assumption that they should be considered examples).

Thanks,
-Andrea

> 
> Regards,
> Changwoo Min
> 
> > 
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > 
> > Emil Tsalapatis (4):
> >    tools/sched_ext: add scx_nest scheduler
> >    tools/sched_ext: add scx_userland scheduler
> >    tools/sched_ext: add scx_pair scheduler
> >    tools/sched_ext: add arena based scheduler
> > 
> >   tools/sched_ext/Makefile               |   2 +-
> >   tools/sched_ext/scx_nest.bpf.c         | 652 +++++++++++++++++++++++
> >   tools/sched_ext/scx_nest.c             | 240 +++++++++
> >   tools/sched_ext/scx_nest.h             |  18 +
> >   tools/sched_ext/scx_nest_stats_table.h |  20 +
> >   tools/sched_ext/scx_pair.bpf.c         | 610 +++++++++++++++++++++
> >   tools/sched_ext/scx_pair.c             | 180 +++++++
> >   tools/sched_ext/scx_pair.h             |   9 +
> >   tools/sched_ext/scx_sdt.bpf.c          | 710 +++++++++++++++++++++++++
> >   tools/sched_ext/scx_sdt.c              | 101 ++++
> >   tools/sched_ext/scx_sdt.h              | 113 ++++
> >   tools/sched_ext/scx_userland.bpf.c     | 344 ++++++++++++
> >   tools/sched_ext/scx_userland.c         | 437 +++++++++++++++
> >   tools/sched_ext/scx_userland.h         |  17 +
> >   14 files changed, 3452 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/sched_ext/scx_nest.bpf.c
> >   create mode 100644 tools/sched_ext/scx_nest.c
> >   create mode 100644 tools/sched_ext/scx_nest.h
> >   create mode 100644 tools/sched_ext/scx_nest_stats_table.h
> >   create mode 100644 tools/sched_ext/scx_pair.bpf.c
> >   create mode 100644 tools/sched_ext/scx_pair.c
> >   create mode 100644 tools/sched_ext/scx_pair.h
> >   create mode 100644 tools/sched_ext/scx_sdt.bpf.c
> >   create mode 100644 tools/sched_ext/scx_sdt.c
> >   create mode 100644 tools/sched_ext/scx_sdt.h
> >   create mode 100644 tools/sched_ext/scx_userland.bpf.c
> >   create mode 100644 tools/sched_ext/scx_userland.c
> >   create mode 100644 tools/sched_ext/scx_userland.h
> > 
> 
