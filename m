Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6C1DA62E
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046238; cv=fail; b=f4sslNnB52uPw5RJRvNgqqUwmf2Ba2GXpg6UkTufWp4sL0YMnVdHFit3BCylmXdXZdO8oapqK500cRoNcsDy/zQukBcRkpDqbY14fWz877FSLPAXCBGHM79NnjgicTRAsMguNM5BtW2i2gt5TT+bhYKkLsQEKDXuUIGLQqnpeCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046238; c=relaxed/simple;
	bh=JbRUBZt/Pqxbogq7PbPPMxdQ/CYkn97xctWi5Zp0mFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fmiu1jowqW60SltYX56CE4vnx8qmkx1sftbKszq602Zl9F3hGazu3XLLQ1rcS4JmN11/F3Cvy23iOfOXsvgSL4HpQIHlgdIZAfITZTbmlezGXGdZ9cKGQKsmCz3MnxvErtL4xoQjfh/2rYqGWz4ZXtXcaT88B1hH7Piv72Biidk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKCpgqBC; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKCpgqBC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMLpcDFaApluhlonxv0vYLdMTp4AcvYjPykuzjMxMnRmv6EQcj6ubP/9xr+j6XzPJI+fZQfSj0TBghKs66dPGB9C1R8IqGpPOp0u4w6aHHnhMMQEcgiAcDUy0/G3yE++IkI9WylPuYg04dEkGMhr4bH9Pe1aEu7Z2gTE+C5OCl2yzrMO6ElaxpJq+kBC9grpV9kCRqLhYRjcWcILooTSLJxg+OtRrT/MyS0KdqYQ69X+poIMY2e4vvsjRiPTVJwYQB62uEmtR0/vYJAWISZsGoZJMsM66HRB0nleiSMDrbwOjQsuhW03H1OAdQpOt7iSDUvdV3JZ6B/IWUmW+A6pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdqhXLB2Qo7/PysHuRHdSwStEWv9fX+bTvhp5aStopA=;
 b=Wk7zojwB2D5z4+gh/q7SQu90ztJsThanGKmDvmfGOFxelyZQ5X4SM4TGl68JsZbSx/vGgKgiuBbBveZY4RmBPAuSA8iPrWe7/JJKC5hTThRZXlFkDKh6sA2PIfjLgqDdb24aKHZkwxDC8oW9vVgG5xnGFrtbebX+11305+MWsX+e20Xbx4mx8D7xRktHka3F9ybEKgt8pp7K7sPKpbuwHFv0t3lsyORAEO04ft1DmmL71Ua8ipFp93zM6PUBUldS3dD6ndrcrTl0Dru4e4MNRNSzYS1MZgtpRWttr4ueXPFa8Rl55721imKjpvVk+JahievgLbSA/mwM9tnBEh6Fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdqhXLB2Qo7/PysHuRHdSwStEWv9fX+bTvhp5aStopA=;
 b=aKCpgqBCKeW/u+2Wa0w2tWNxtwGXRe5u9rG3Ak757j0Zx/MIJg0jioMBD6oJJti2sZU8C9NLiffiXLqWvTFd3N2XS4oV9oSQXfwioNz9pOXJLs08A1RtWUmP19O40Jaxaj2An34TezpbJHXIKTr5lP63xtF+/Mfl0BiUAL9muA9qHYtfECszgbOhq0/ZW20z+cflhwxsIDD95kFUysVCipFykHDsrzPZTuETTcqwtj2fTiCtQoe4zi+ZT7kJOvrCViztpnY9wgWbAPIglIcZPPHub65feZhFXYcf4kmBtSbUHSoKrqKPHWbmmWA66waUJvu0gB1TUlNQqUZLM6eX/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 15:30:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:30:32 +0000
Date: Mon, 2 Feb 2026 16:30:28 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYDDFDl6ti-LqRLD@gpd4>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org>
 <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
 <aX3FG00RNMv8VnQQ@gpd4>
 <DG2YT5LJFC9T.AXB2OHJBQG4U@google.com>
 <aX5lkCVr9uU78DxL@gpd4>
 <aYDAl7Q40rbbakrq@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDAl7Q40rbbakrq@slm.duckdns.org>
X-ClientProxiedBy: ZR2P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 93374053-1a41-4011-1008-08de62700057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wJqrTL7tQlNCp79uegjapvtUj2EXpJn9qhJid0cjaqdmomDPzoVpwvpqBOd?=
 =?us-ascii?Q?OGGLLGkJKi8UqLhshtBnkRx8Th9N+ZINyyt+9ohU7lpEog7OUcJ9/rvA5I2k?=
 =?us-ascii?Q?Rb8NcUQ6+ObdCwmaCiRI4CgHLOvXNLV3XCsXZbXwo0lR2etxwX0R1jekmQo1?=
 =?us-ascii?Q?MpxEEzKG9vuJzTh1iuZ0E5h5AeLOLlykSiskHEeOQdC7agiMlA6qdvIU9hYV?=
 =?us-ascii?Q?kRxeiin8nxZr2CEiwycBkLAJVUv9oVcYL5aj6c3wYnwxTalwbEfAKzlQRvYN?=
 =?us-ascii?Q?69Fm97PsLknEUSX/6Ep9MWnHJZlONYaFX4gzrZC6JiLlNXIglcpN5IKMDrYr?=
 =?us-ascii?Q?tDdT2pcbfO9Tkrow7fyGp6nilcWx/SgsaNKIdQUqBX8CZurLH7j9L9Kf9gJJ?=
 =?us-ascii?Q?x8vkox11aIH6ooDpqO5/G8BcW/li1+j0mpXopcXnstPH+7VhvzZ5nN76i94a?=
 =?us-ascii?Q?WWeimvqcMz7rOxiSE4/4ryMOns3ixdRgKAKVrvc6VQtFZbn77U2zWWfNbQd3?=
 =?us-ascii?Q?Rnfc0WcIw0bS26BDvQLmXazvz4nWyj28HkiYK/dcTmv/pIGW6ZZlDNeRaPby?=
 =?us-ascii?Q?EOhafa4nRqWSS51SZA9fHMyhBZFtHOznPJPaRWoJYynsxTcbEWN7BBp8h8G+?=
 =?us-ascii?Q?Sa/ULI3jh5pqWIUHrrBRGhdxUf83IdVEdVuXNUJFtw1uBDNRyJGIuHGJgslo?=
 =?us-ascii?Q?hBGRDQlGhlnci++OEPBHMLMk4u0PQSCsQpBduKtot7FurtkG4yQTXDOILDfd?=
 =?us-ascii?Q?o2H6uNksMqxaXh+Ae4UcD8zUzBke+RpKuOUXhXNeRGOyIyT4yEkteT27UyoO?=
 =?us-ascii?Q?ky4UwUTtX78YJrIzCvJMhYsECMNmuG+/U3RIKYWGsdZjjzWYI/SeE2bVf1w9?=
 =?us-ascii?Q?FZo3qeNJaV12UL1kk5SHPIDkjd1M4oMw31d2FJ3G3Kro3RJKTOac1EXwigqk?=
 =?us-ascii?Q?NYZm/5dfHZV5QV9MBhtBt5GPoapyiMCk6joA55MxiEjSiH9KXTBnstJoyWig?=
 =?us-ascii?Q?7i2FjaKzP/JTwMYgk5fMJ0oVkwGpIWcIFE22by7hMN4Cm/VfupraXHptBBle?=
 =?us-ascii?Q?7Wzv05//iGUVcBbtn6Jh9ldkgchxyrkeWd1edTeU5M4exmX832t302sGQW4u?=
 =?us-ascii?Q?NX1HHwcoHbCxu42/bl468aL1t31KWcRBRrCfrpZG6J0IyNKjMdqQZvQ9k659?=
 =?us-ascii?Q?Jf5DG7YbwoNl6nRyqtx+MNFahmSjLkmRCxjrz98G0maFomiWQx7hAUCL3PFr?=
 =?us-ascii?Q?n9RzvAbsPeqRgM76ZSIvx4fbkjQFmxK6FyHxXvJZFDlvWj9ub1uGjzta3o1F?=
 =?us-ascii?Q?8bN3wX/MSjdSaaU22x64IdZXb9CZbbZ/e5kbgasYlJoC4RnL5JHhUNfbtsck?=
 =?us-ascii?Q?DOd9TDQ2/ag7/rZvxbzvdLO/aDdFCjx8wokOuwIFMv9HBRl5WTej6PzYcV4R?=
 =?us-ascii?Q?BvCEAqV4cBohHgIWF5Z2kzcI7HD64PYQGbE2rlx74Bgyt/B62FxJ6guIqdnp?=
 =?us-ascii?Q?QvZ94cqcx13Uyn2m4xVKuK0eyDREKhnvnUemZtLEIQhNbKdw0yL90ocBJb9o?=
 =?us-ascii?Q?epVcdIUowxCGIIHQYq0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ShJKNBLiBmKBtuezO4CSI9e1qC/t0IUPOJu4qzezUyCGxAL6cEnp4/LI3rYM?=
 =?us-ascii?Q?g6Y7srpyC2XuWLfJrVrR2dP2tf07LrtWHzsA9vVVC3hJ8FSHrv6cLzq0KsAT?=
 =?us-ascii?Q?MqzcsHHNzvPg7qMYSvR1wuEWXzyKC6CAzW5tON0+9sv4AMze2V+CaW5W+Wq9?=
 =?us-ascii?Q?oHxDjlr2yVB9YQzrxqpcBGkjuWe7ohzVxzVyk80VqkqnnfENLhYT41F3oDoJ?=
 =?us-ascii?Q?9Ift19NcfC6G06VsrJ0fbKoHDMFPjxl8lh5AaqdteSxCtaSMRy1lB8DOmGcr?=
 =?us-ascii?Q?Oie+Qovm2lNGNnY8xKpQFXKax6yAHNbNp9mkXWlecStBETLa/QD60Qat8N2C?=
 =?us-ascii?Q?lDkhSunaHBXWJP29k/lmsS8cHglr5oh2xtZMIB41RWLpqv7GG2dqVm9or4iq?=
 =?us-ascii?Q?p1mwWULT4NWiE8esxt6oxO93KUbzgWLqXxz5W9Ek4hEydaHJeDW9IhcFVBiK?=
 =?us-ascii?Q?f0wsgiUa6buQ+HdDIAzcetVXaUu389St48Ke74yDwoZsf4/AOGowSVgfh94j?=
 =?us-ascii?Q?V+foXorTbXeM3foEhahCW7KJ/67FeciEUvsdo+Jg/G79viMmu09zQOCrQJfP?=
 =?us-ascii?Q?hxAm0iceWI35OS/AXZExJimQ2sQE6e0vJjGOxMUnv9QsYMIEeApsatFovuJT?=
 =?us-ascii?Q?TZttL4tunX5g+UN/44NOaiXZFGz7dXPX0aZ112063rk4DgmlB6+rsp08oM+n?=
 =?us-ascii?Q?/gLtcsANE6BnGQc39BVNGEigJHUNNlUF6tG/OmDQmly6QNSl6ocH0HoY9UVG?=
 =?us-ascii?Q?q0szy5msNWuE5b90eggCEm7OiViBFccclAioWmksoA4cuSnx2VkMnPIdTa7A?=
 =?us-ascii?Q?nLnN2XgqFEIK8W1t64aaiSSTPSoJNVR5tOUFTmenapaxVsrn8kK00peq6v5T?=
 =?us-ascii?Q?t5NUsRV3bhyNtEfWbNftHgqlnBiglIkFgOrGR1wafsNlmtopL1aGiI6WYekA?=
 =?us-ascii?Q?k2/FV0JkY1BK8axDfyvSJgrszlSN7Zjxs/qReopBlZeRiS8/RDsdd2QOAjxP?=
 =?us-ascii?Q?L0yYyrWyeShWUOcrwa/z89uvZaYJg3gJ1zE7LUfr5QzRL6ZIlqDKED2acfoT?=
 =?us-ascii?Q?r3CjKLWWzOYd+MwUNYyUzRvLxTDORn9Lb6DejjjDIjRBqYWIMIUDHKuprPru?=
 =?us-ascii?Q?y/mIvD/vCEppzTbtIdy/ZlEZs9WWm6C38LoMSQis8w3Vv1FCR5ObTEJVwqyn?=
 =?us-ascii?Q?A520ThDvuRGy5elAW/IMHNfgh22Be/oSDxkhSyvVtkrJ8emyMJrPcsasESu/?=
 =?us-ascii?Q?GweT/AZaxq7hRUsgCNSThWWOv52MC21U13oHsyo/ixFo/SfWYJy0QejwtuAL?=
 =?us-ascii?Q?IzPxoiZ9nJupMKPY8aHHBV5ea3dmX2ZCw+PWD7uKuCf89QlbvHZprRWgWuKF?=
 =?us-ascii?Q?2y8GstuQrOBUJ5A2OmOsPN3o2hN8ypdi/gF/pIQ6BITetZC3U0i9G1IYIfyu?=
 =?us-ascii?Q?kNMmy7cYEp73GWLdAI6eRNOETF13jRfz/LMYqer04FTNlmdbMi/rbEo61yKG?=
 =?us-ascii?Q?ornA1mi1p31rHmXDmE1E+gXKgzInF1tMawSeK0WsCOTVWBYZdFf/MWtn1T9S?=
 =?us-ascii?Q?6HU+KVU/7TK2h3rqAcWrNn0xabLlpOGsIOS68pliCMQEb0pJKIzWJebMqo3A?=
 =?us-ascii?Q?CnR3zK4d5k+Nc0o9BTwmGIs4uTcF94m/ZjQNbd9eE+C/QFP76ho94vIhUQES?=
 =?us-ascii?Q?7J3kHbD0wHWxxYMmy8izAe8OR9xFe40jOEBR6F0s60fxlvIk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93374053-1a41-4011-1008-08de62700057
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:30:32.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOSE9+96/Qhch3UyJ+3lU1FTvomCyzydCWVthph0FjEwlklv0lWv8ODQtm7rtxQO+ChsrQ4YIxVW26kxTQTsFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911

On Mon, Feb 02, 2026 at 05:19:51AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Jan 31, 2026 at 09:26:56PM +0100, Andrea Righi wrote:
> > I agree that SCX_DSQ_GLOBAL behaves differently from user-created DSQs at
> > the implementation level, but I think that difference shouldn't leak into
> > the logical model.
> > 
> > From a semantic point of view, dispatching a task to SCX_DSQ_GLOBAL does
> > not mean that the task leaves the "enqueued by BPF" state. The task is
> > still under the BPF scheduler's custody, not directly dispatched to a
> > specific CPU, and remains sched_ext-managed. The scheduler has queued the
> > task and it hasn't relinquished control over it.
> > 
> > That said, I don't have a strong opinion here. If we prefer to treat
> > SCX_DSQ_GLOBAL as a "direct dispatch" DSQ for the purposes of ops.dequeue()
> > semantics, then I'm fine with adjusting the logic accordingly (with proper
> > documentation).
> > 
> > Tejun, thoughts?
> 
> I think putting a task into GLOBAL means that the BPF scheduler is done with
> it. Another data point in this direction is that when insertion into a local
> DSQ can't be done, the task falls back to the global DSQ although all the
> current ones also trigger error.

Alright, it seems that the general consensus, based on your feedback and
Kuba's, is to treat SCX_DSQ_GLOBAL as a "terminal" DSQ for the purpose of
triggering ops.dequeue().

I'll update the logic to do the following:
 - When a task is dispatched to SCX_DSQ_GLOBAL, the BPF scheduler is
   considered done with it (similar to local DSQ dispatches).
 - ops.dequeue() will not be called for SCX_DSQ_GLOBAL dispatches.
 - This aligns with the fallback behavior where tasks that fail local DSQ
   insertion end up in the global DSQ as a terminal destination.

Thanks,
-Andrea
