Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ECD3730D1
	for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878905; cv=fail; b=jNt+Fr/wTj1lWViVm4kzPNCDD6eEHjMf2AdBiC4j5P6jOZhKEorW90GWu28YUvseinDAKv8y+5VEdqDTI1VRGiOcINyAEhf6SyJ2WXdSPGX9EQh6TqybQSe7Tv7q/w+Z5v1PQvum4hOV/urOawTTA8TtFsW0rz9gpqxvEz+IwRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878905; c=relaxed/simple;
	bh=ClWJcCo88/aNEWhcfvrh/DluZzlIP/zJD+uVbN//ikw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=SSJQK/tPBwbm3E41itE9gZoyJBJHaU2u68TB5EYtsRxlD1vHr5d2OnR+1q4gYT2LSWPoxXFtiecCCp1uBLbVLQGh6O/YSTtfPcYEmLPfN+06KmBvPTtjR2ap/FUHrGHbd/BwjthNEJxsuLTNsi64NH9zO0TrH0+5yu7r7XOiDj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Rl/vi4Vy; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Rl/vi4Vy"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABCFFa81434102;
	Tue, 11 Nov 2025 08:34:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ClWJcCo88/aNEWhcfvrh/DluZzlIP/zJD+uVbN//ikw=; b=Rl/vi4Vy1KDQ
	5n3bSGaiPGc2SGNnyNxfq0G1gUjXkm8YgKNZDDjy/Em+8o9bV+Y8huQxN84Djz0+
	Q9CHS4UQB23YAzpg8U/DA5hDzcOF6ofEjJLPXsZnZ7/ZZMT2Ejf+1f1ZZ4Df59q/
	EzbB2XhjIVWWPIdT/As43BLiI88bnlrdRewcYn2cjuk6ju2hJk9X9QxdMgL1CaYQ
	jVuzUtJ7FWR1dd4b9EqfB/Ft9atOQkZU86mHzgk9rNl6WMOjA2ArlqHHR3/ZxJjo
	eE1ShErsW+uVfKv07OdVcnuyctQNUQ3NSuXObhhE6ZFC6zcIZRustEICrC7l0zdQ
	7GPxSflBJw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac5029xen-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 08:34:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lfbp0NPwypPh2np6sU+QphJFim+7FldClHp8oxCshy79poKuMl3LKmg0/+PG6zQ+Kv/xeKiNBnuhgZxdSDYeStch0QOfdwHNezHmV1jB4jXZodlrWwpbsbRxpuiRL/OHdzKRFwhBzzXImxboYGDv7PV+DGc5A0RVBvL2NUTfscG47ueTH+VxiGO5c7LnVJ/dzgmicVlkFRpPrD1j/M6C84nRT55d9Bpn4qShU+b1H1Vb2q9X0RhitHQngZ66EScainEwEwMchkF6sktrpmmKp+FoY/puQcXQy/NrNiv2W/btnb9BmiaOxsMJEpArrrd3FJUzrIzNjLqI5l9v5WlqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADa5rlSpNMglu2JkjAG8LdVtO0lGbvaKK0O9xFanvNg=;
 b=pGmOAPS8KzwGgQwTIlF/9s/1IE9PDHtta8NWo97DaNjMZiF06GeqFHDZZrZC5qtk0kqMvtwPSmEmIOqYXmlHiLs2T4eGPehPbcgBI2/E/m63fot4/RE8ME64OxIgW2l3qn3iQQY9CcDNK8oe4lD623ARK1xvKxdq/DNAD70/8QFsI4WU5vCZ0mTXNkJEiJJRkgPeFBVk1UiAUF9IVH2XgU9uTWLLL1wTyjnp+mI38aDAO0ePDBZfrhiI21QMkjkKFLIikGjwQVe1QaZWg0j/kzw4J4eNcaiTSrs2bgbDHODUNJnzY99Bze58j5WOP6c8Hbkm6YOVwmihkZTi9CCy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH7PR15MB5318.namprd15.prod.outlook.com (2603:10b6:510:1e1::14)
 by IA0PPFCE61BADDD.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 16:34:23 +0000
Received: from PH7PR15MB5318.namprd15.prod.outlook.com
 ([fe80::34e5:c585:944e:6e30]) by PH7PR15MB5318.namprd15.prod.outlook.com
 ([fe80::34e5:c585:944e:6e30%3]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 16:34:23 +0000
From: Emil Tsalapatis <etsal@meta.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi
	<andrea.righi@linux.dev>,
        Changwoo Min <changwoo@igalia.com>
CC: Dan Schatzberg <schatzberg.dan@gmail.com>,
        "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH v2 05/14] sched_ext: Simplify breather mechanism with
 scx_aborting flag
Thread-Topic: [PATCH v2 05/14] sched_ext: Simplify breather mechanism with
 scx_aborting flag
Thread-Index: AQHcUoSHm8dY6L9N4kqtNgKdQGII6LTtq8i2
Date: Tue, 11 Nov 2025 16:34:23 +0000
Message-ID:
 <PH7PR15MB531810A1CD33803AF56EFEDBC7CFA@PH7PR15MB5318.namprd15.prod.outlook.com>
References: <20251110205636.405592-1-tj@kernel.org>
 <20251110205636.405592-6-tj@kernel.org>
In-Reply-To: <20251110205636.405592-6-tj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR15MB5318:EE_|IA0PPFCE61BADDD:EE_
x-ms-office365-filtering-correlation-id: 61ad80e1-7ccc-47dd-4bb5-08de21402c1a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Xqq2hyHwIOdLIXcfqf7FZQezDfc/ytI4+o1q87anr3J2vsTE3yFa6YIOLP?=
 =?iso-8859-1?Q?cxwzhKw7EDPbuDoGsQWKppD7j4MdziVPUgf9bJKJnDh9Xl9bDgD+IG49mW?=
 =?iso-8859-1?Q?tQWV6IM7vg0F87gYBxbVNlWTDRlSEFY9T57ityLg9rRiFbigzM9hxFYYnC?=
 =?iso-8859-1?Q?7YdfvJH3plyx9mRVbYmM0ByYvIqT9oUAvDfQinAo51IOIzKImDG9wx5wS8?=
 =?iso-8859-1?Q?D9Q3NzdFRqum2akh/oXZUGBeLjp8rgJY9yA1x7BI8ENLkqpzFAh+mDUpcw?=
 =?iso-8859-1?Q?rbRNqHNc7sOPK5lvLZVETf4lC4dxr0eS6V9ovi1QgMADiX9At5MG7LPZA+?=
 =?iso-8859-1?Q?OV1at4BcHBUMfZNAevExyncms289v7etCDW9opuO+DjLC+d6xAZOA1/kGi?=
 =?iso-8859-1?Q?gJbUeqv0kjevXOJYcGLR6+IaivA3jduUnHLAs07WVtmfnvbzBkV8m7hFpG?=
 =?iso-8859-1?Q?C6bfiAt65KVxygFPEgXFBhyIt+9CEMMxb6HBXkTE6Eh4tuIAkme9muEZhY?=
 =?iso-8859-1?Q?9D+eah2ABks/25U5dTuHkz4cp3wrYFYba6/oWVL+mDGaygw0R+ODhx2Au8?=
 =?iso-8859-1?Q?mueMBDBEgSpRwCVuQ5Gt6o6z/X+ksYbbskNJnadUswIo06CA/o43xxGxH+?=
 =?iso-8859-1?Q?vcPP6Bm8urR4PWRE/CIXxggajgCEOV68L5zcv2jNICT4TzKwsApdYI6iWc?=
 =?iso-8859-1?Q?Ehb1CDb8HfVuiffZZ8DW5Z5QXb2gC+QFwVC52/Fy4iR6CdMa/qEaMs0mmH?=
 =?iso-8859-1?Q?n/Emw/q0fF4qqGElhWSUUMXehkOqPuTjOkQwYyNx37UqV3Vb8uMSdW3zyh?=
 =?iso-8859-1?Q?H9kKS0sJP/jlsNeN2pL9+tqk22hjWYH099/7He/7Rsy9fE2Hnan3pTN7uY?=
 =?iso-8859-1?Q?IeEqaUaN5ZKHYlkIqIghRWyX3I9Aco9jE1blTURYCaQE6A8sRxnWv5Wydb?=
 =?iso-8859-1?Q?/tbuSOZjPKeWhZh7PoqHs8xt/v9gHtzgSUS6GiNk5coXTpMKCF0dHR3xEo?=
 =?iso-8859-1?Q?sZHLJgoEzJdHNAClaMq0W6cRCw6jm4Yv7zabCwso2zcpa9/Q7rYAFveQIw?=
 =?iso-8859-1?Q?byUEHexVfJqsbQk19mMoj5V6lsRME00hLJjlcIGp54WuENsG3fz5L2UXL4?=
 =?iso-8859-1?Q?p7byIceG4EpxEZ3ROmDLY+awV+M8utyXRhu4OeK234Z3odojHVqg6L80vu?=
 =?iso-8859-1?Q?FXdowLUDFtvax9n2hnL7Rv+1AtLpcrjtRUYiG6jYEviClTUwqxQIsQZR/N?=
 =?iso-8859-1?Q?aSwfxf++23EYU76k2UXW9AVeSt+ZehERnl5Yl+v43TQbOS09LNywNIp+rp?=
 =?iso-8859-1?Q?renN+fCxA45l2sHuzqQ7TT+MAR9rLG8gSj5M/NZ0ernHv0qXD6zP0RCgWY?=
 =?iso-8859-1?Q?E+RE4U+3Z5R8QCcmiYXFxjf+NJ2CoaGAIUrjpC05Ejwe93rzLTTMBQeraL?=
 =?iso-8859-1?Q?xz4GrrBy5oJGp5cWNG9O+lJaTOt/syxkjDdNMviIozdoHCPKiNsnm/M2QT?=
 =?iso-8859-1?Q?rXgCVJR4olHNX09MnPyxGIMrwQRNpGzJkj2EvvsdDpFF8AcLJFxdqRmUw2?=
 =?iso-8859-1?Q?uLVdFCa5I6gJvc/MFDZl7Y43dw4Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR15MB5318.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+UFxzjlNRfO06gTWKlagdRVmmmZMrTnHe844StTv9ZnVALNckkMbKBAQnd?=
 =?iso-8859-1?Q?A9kTNsQ5/DGNnixj+gQSDd6W8dJwddO0YKh3pihoP+/6uMnKfdTTikixAV?=
 =?iso-8859-1?Q?bQRIAWJ/TlDY2RGorMWKnaXE7BUB3s5TDkm3SGEaJAcg4GvgVEf3eby7My?=
 =?iso-8859-1?Q?eIGwjGkhCMSUgiWfr/hEQ9G3sdjOk+9wxwO09TRZpbVeLK4mQFJF6Vemzt?=
 =?iso-8859-1?Q?9uGLGUz3lV4Mz+vZPNGF2mSjROPXzRdmniyMhpZPj8nlgHdLrkZxTjPhVi?=
 =?iso-8859-1?Q?gcGqdDluila2gGeBzK3+kvLQ0zPv0R1/zRFjrgcJeeGkSvqOpRo1T2U5S9?=
 =?iso-8859-1?Q?f/yu54tK4X3Dtgcb4yshOM7O8LEgSmtp5JflSPekXccVRz/axG+f7yO38r?=
 =?iso-8859-1?Q?ct221zDZumX2z/f52eeRNzUn0jP4lW4h9YIa0rC4AnANVL9X3AzCKJNL38?=
 =?iso-8859-1?Q?ipr/exokWNAw0K6TgnDTpgCzDvTuEKuG9+dzi0hOuW/1O8MX9rPoiNrdml?=
 =?iso-8859-1?Q?Noy3Bt7vkuXqgMLJuyuoP44Ojao9vgBTTC6P1qGEP/UfTHkYhnj0sxeGN4?=
 =?iso-8859-1?Q?KeOyODceoFTwhiXOfVOdz7AfbgT32VIcwc7QVqymDn3hC27cPypWE/BopO?=
 =?iso-8859-1?Q?toka4EVODK7pBe9qK6GPtvLgJq33vS9Rvt/3rdV+SNL866b4s+6ozosWgt?=
 =?iso-8859-1?Q?DO00Qm88MKOC/kfTa8z17SeIbcRGSdSYa1PsDv+Cp76sBpd5Yz0+tDTCMr?=
 =?iso-8859-1?Q?oY8zqKa6qhJhIdJC3HuZXhZAkP10V6D2e20eU5ZGoOkJ45NkwJwitdnas4?=
 =?iso-8859-1?Q?bzXS/H+KzgutbXRIWJBrG/beJUCTP841fvfXz3frDjfOcABEgbBbA/R4bS?=
 =?iso-8859-1?Q?azK4W7/S7TfBQ0jwHaKQHeaB+0z0D4bPnHkPAZDnqS74I/5pzQ0gOQX+aN?=
 =?iso-8859-1?Q?/enVlrqRAyw352GlQNSYvPIfcPc6vKeMEW7m/LCc9QxJYgQMLzTG6F4kf/?=
 =?iso-8859-1?Q?ASKhc+vWl79W77HLfW7VNEPdBBFFKxRPXw6Em708HIW4dPi/Cm1+mi8G86?=
 =?iso-8859-1?Q?7RzNMd9hLUJ8a7zPBtvILiXWcPLMmwBOGzzwOlHfELOQISv0nqFzFkPfV8?=
 =?iso-8859-1?Q?3/a6E2Ls1gWwMCZIrUqsKNwfwrKfNZXP74SErXgZsLxg+IvVOPrH2OIKZ6?=
 =?iso-8859-1?Q?UA80JuB7XInJSB6LKftbz4RkUQuR7iJ4MkE+aQDWPj44bGPULnpI/PrMtk?=
 =?iso-8859-1?Q?D2KZQxyyqwhEmr/t2g1+jr6aiDZkHchJNOAOv6MsmWF1nFgqjG66LGmEHc?=
 =?iso-8859-1?Q?OxK1TO+JjYoTpLVsLwza1bBlWXHqKdL+yW/aOr13w9GPc5wDV3ek4xHeu6?=
 =?iso-8859-1?Q?UqfvVHzRnABHm5ThIpnxBWwS3FkHDsQLlBfZdiat2UwEkOf57XOejrE4lE?=
 =?iso-8859-1?Q?SOZJldJK2UKLuIfS9IFV9tD/lTYU+sp0IfQyzkLidWcoDNwiFOlNKKUtHs?=
 =?iso-8859-1?Q?s2Bhn6KjZx1pNCsdAPy+lzB1+tYKuj2IQkthUX+cIniH9mDaForuZ3wzAN?=
 =?iso-8859-1?Q?vAHGLus939cIzsXRue3g+Sks0sWVT+6kfkdSYtCakOKFJkTsvXz/6rUDhA?=
 =?iso-8859-1?Q?hYFmJp38W0UhlG+OFb5qvHdZpGk9iP43FW?=
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB5318.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ad80e1-7ccc-47dd-4bb5-08de21402c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 16:34:23.4511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGm+YIHYpS6IRFPAoViF6xWlVuMumWyjRGA1ucc4N8/NIxqwKUWFsPpbNjwwt+FH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFCE61BADDD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: RueQzsDKPAZ0dR_yVsYFswpsyjICmsZH
X-Authority-Analysis: v=2.4 cv=CPInnBrD c=1 sm=1 tr=0 ts=69136594 cx=c_pps
 a=YOgfsySBG6Gh3lLixmEA+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VF6qZnJ4AAAA:8
 a=V2sgnzSHAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=Ikd4Dj_1AAAA:8
 a=CWErhr8FAAAA:8 a=tJa6dLmWWyylHZLjZGoA:9 a=wPNLvfGTeEIA:10
 a=9q4iEFIXrH76IA-M63OW:22 a=Z31ocT7rh6aUJxSkT1EX:22 a=gKebqoRLp9LExxC7YDUY:22
 a=I-g_0vLIplkVOQ0FYkeP:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: RueQzsDKPAZ0dR_yVsYFswpsyjICmsZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEzNCBTYWx0ZWRfX34GZe0zKvOMe
 DPOgZS8yJaLaDnJgS2FDF1bBAegx2RW8xOvMZ5ylaY2bZWkLg+439NpY/3UWhGDcMVKGhwsyRlL
 NXGgsQd9V+Y3dUlzAiUWQ3s2uoydmO13KObN+Ght2U309LYND+1OaLrp9GRLFYxGUawl01zqbNK
 lNrGJlZGpFt9zWynASuwMKBtEf4oy4BUhDpuep5lib0VtmJ2E7rrZB+oaBuWnjqCaqHK3KRAq6w
 d6K1FIpIQVlA1icLFCZHsCFubR8ZVctYNqjYG1RxPRpRwi442XXTvmjM2Q2ENdZKVivvEbnBJnX
 XhQx8QS/WJemLdPYtD6ms4oIpswMCcSJtIIOpktQUc2GMGctucKdpO4uiOZMrVsUt+xYb9V0m0R
 9s3IAOGf2Bt+OpQhqrXcPgpgHB8IbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01



________________________________________
From:=A0Tejun Heo <tj@kernel.org>
Sent:=A0Monday, November 10, 2025 3:56 PM
To:=A0David Vernet <void@manifault.com>; Andrea Righi <andrea.righi@linux.d=
ev>; Changwoo Min <changwoo@igalia.com>
Cc:=A0Dan Schatzberg <schatzberg.dan@gmail.com>; Emil Tsalapatis <etsal@met=
a.com>; sched-ext@lists.linux.dev <sched-ext@lists.linux.dev>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; Tejun Heo <tj@kernel.org>;=
 Andrea Righi <arighi@nvidia.com>
Subject:=A0[PATCH v2 05/14] sched_ext: Simplify breather mechanism with scx=
_aborting flag
=A0
The breather mechanism was introduced in 62dcbab8b0ef ("sched_ext: Avoid
live-locking bypass mode switching") and e32c260195e6 ("sched_ext: Enable t=
he
ops breather and eject BPF scheduler on softlockup") to prevent live-locks =
by
injecting delays when CPUs are trapped in dispatch paths.

Currently, it uses scx_breather_depth (atomic_t) and scx_in_softlockup
(unsigned long) with separate increment/decrement and cleanup operations. T=
he
breather is only activated when aborting, so tie it directly to the exit
mechanism. Replace both variables with scx_aborting flag set when exit is
claimed and cleared after bypass is enabled. Introduce scx_claim_exit() to
consolidate exit_kind claiming and breather enablement. This eliminates
scx_clear_softlockup() and simplifies scx_softlockup() and scx_bypass().

The breather mechanism will be replaced by a different abort mechanism in a
future patch. This simplification prepares for that change.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---

For this patch and all subsequent patches except [13/13] (still haven't rev=
iewed it):

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

=A0kernel/sched/ext.c | 54 +++++++++++++++++++++-------------------------
=A01 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4e128b139e7c..2a171338d8f4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -33,9 +33,8 @@ static DEFINE_MUTEX(scx_enable_mutex);
=A0DEFINE_STATIC_KEY_FALSE(__scx_enabled);
=A0DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
=A0static atomic_t scx_enable_state_var =3D ATOMIC_INIT(SCX_DISABLED);
-static unsigned long scx_in_softlockup;
-static atomic_t scx_breather_depth =3D ATOMIC_INIT(0);
=A0static int scx_bypass_depth;
+static bool scx_aborting;
=A0static bool scx_init_task_enabled;
=A0static bool scx_switching_all;
=A0DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -1831,7 +1830,7 @@ static void scx_breather(struct rq *rq)
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 lockdep_assert_rq_held(rq);
=A0
-=A0=A0=A0=A0=A0=A0 if (likely(!atomic_read(&scx_breather_depth)))
+=A0=A0=A0=A0=A0=A0 if (likely(!READ_ONCE(scx_aborting)))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 raw_spin_rq_unlock(rq);
@@ -1840,9 +1839,9 @@ static void scx_breather(struct rq *rq)
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 do {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int cnt =3D 1024;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while (atomic_read(&scx_breathe=
r_depth) && --cnt)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while (READ_ONCE(scx_aborting) =
&& --cnt)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cp=
u_relax();
-=A0=A0=A0=A0=A0=A0 } while (atomic_read(&scx_breather_depth) &&
+=A0=A0=A0=A0=A0=A0 } while (READ_ONCE(scx_aborting) &&
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 time_before64(ktime_get=
_ns(), until));
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 raw_spin_rq_lock(rq);
@@ -3737,30 +3736,14 @@ void scx_softlockup(u32 dur_s)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;
=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0
-=A0=A0=A0=A0=A0=A0 /* allow only one instance, cleared at the end of scx_b=
ypass() */
-=A0=A0=A0=A0=A0=A0 if (test_and_set_bit(0, &scx_in_softlockup))
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;
-
=A0=A0=A0=A0=A0=A0=A0=A0 printk_deferred(KERN_ERR "sched_ext: Soft lockup -=
 CPU%d stuck for %us, disabling \"%s\"\n",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sm=
p_processor_id(), dur_s, scx_root->ops.name);
=A0
-=A0=A0=A0=A0=A0=A0 /*
-=A0=A0=A0=A0=A0=A0=A0 * Some CPUs may be trapped in the dispatch paths. En=
able breather
-=A0=A0=A0=A0=A0=A0=A0 * immediately; otherwise, we might even be able to g=
et to scx_bypass().
-=A0=A0=A0=A0=A0=A0=A0 */
-=A0=A0=A0=A0=A0=A0 atomic_inc(&scx_breather_depth);
-
=A0=A0=A0=A0=A0=A0=A0=A0 scx_error(sch, "soft lockup - CPU#%d stuck for %us=
", smp_processor_id(), dur_s);
=A0out_unlock:
=A0=A0=A0=A0=A0=A0=A0=A0 rcu_read_unlock();
=A0}
=A0
-static void scx_clear_softlockup(void)
-{
-=A0=A0=A0=A0=A0=A0 if (test_and_clear_bit(0, &scx_in_softlockup))
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 atomic_dec(&scx_breather_depth);
-}
-
=A0/**
=A0 * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
=A0 * @bypass: true for bypass, false for unbypass
@@ -3823,8 +3806,6 @@ static void scx_bypass(bool bypass)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ktime_get_ns() - bypass_timestamp);
=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0
-=A0=A0=A0=A0=A0=A0 atomic_inc(&scx_breather_depth);
-
=A0=A0=A0=A0=A0=A0=A0=A0 /*
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * No task property is changing. We just need to=
 make sure all currently
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * queued tasks are re-queued according to the n=
ew scx_rq_bypassing()
@@ -3880,10 +3861,8 @@ static void scx_bypass(bool bypass)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 raw_spin_rq_unlock(rq);
=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0
-=A0=A0=A0=A0=A0=A0 atomic_dec(&scx_breather_depth);
=A0unlock:
=A0=A0=A0=A0=A0=A0=A0=A0 raw_spin_unlock_irqrestore(&bypass_lock, flags);
-=A0=A0=A0=A0=A0=A0 scx_clear_softlockup();
=A0}
=A0
=A0static void free_exit_info(struct scx_exit_info *ei)
@@ -3978,6 +3957,7 @@ static void scx_disable_workfn(struct kthread_work *w=
ork)
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 /* guarantee forward progress by bypassing scx_ops=
 */
=A0=A0=A0=A0=A0=A0=A0=A0 scx_bypass(true);
+=A0=A0=A0=A0=A0=A0 WRITE_ONCE(scx_aborting, false);
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 switch (scx_set_enable_state(SCX_DISABLING)) {
=A0=A0=A0=A0=A0=A0=A0=A0 case SCX_DISABLING:
@@ -4100,9 +4080,24 @@ static void scx_disable_workfn(struct kthread_work *=
work)
=A0=A0=A0=A0=A0=A0=A0=A0 scx_bypass(false);
=A0}
=A0
-static void scx_disable(enum scx_exit_kind kind)
+static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
=A0{
=A0=A0=A0=A0=A0=A0=A0=A0 int none =3D SCX_EXIT_NONE;
+
+=A0=A0=A0=A0=A0=A0 if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
+
+=A0=A0=A0=A0=A0=A0 /*
+=A0=A0=A0=A0=A0=A0=A0 * Some CPUs may be trapped in the dispatch paths. En=
able breather
+=A0=A0=A0=A0=A0=A0=A0 * immediately; otherwise, we might not even be able =
to get to
+=A0=A0=A0=A0=A0=A0=A0 * scx_bypass().
+=A0=A0=A0=A0=A0=A0=A0 */
+=A0=A0=A0=A0=A0=A0 WRITE_ONCE(scx_aborting, true);
+=A0=A0=A0=A0=A0=A0 return true;
+}
+
+static void scx_disable(enum scx_exit_kind kind)
+{
=A0=A0=A0=A0=A0=A0=A0=A0 struct scx_sched *sch;
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 if (WARN_ON_ONCE(kind =3D=3D SCX_EXIT_NONE || kind=
 =3D=3D SCX_EXIT_DONE))
@@ -4111,7 +4106,7 @@ static void scx_disable(enum scx_exit_kind kind)
=A0=A0=A0=A0=A0=A0=A0=A0 rcu_read_lock();
=A0=A0=A0=A0=A0=A0=A0=A0 sch =3D rcu_dereference(scx_root);
=A0=A0=A0=A0=A0=A0=A0=A0 if (sch) {
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 atomic_try_cmpxchg(&sch->exit_k=
ind, &none, kind);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scx_claim_exit(sch, kind);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kthread_queue_work(sch->he=
lper, &sch->disable_work);
=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 rcu_read_unlock();
@@ -4432,9 +4427,8 @@ static void scx_vexit(struct scx_sched *sch,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const ch=
ar *fmt, va_list args)
=A0{
=A0=A0=A0=A0=A0=A0=A0=A0 struct scx_exit_info *ei =3D sch->exit_info;
-=A0=A0=A0=A0=A0=A0 int none =3D SCX_EXIT_NONE;
=A0
-=A0=A0=A0=A0=A0=A0 if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
+=A0=A0=A0=A0=A0=A0 if (!scx_claim_exit(sch, kind))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 ei->exit_code =3D exit_code;
@@ -4650,6 +4644,8 @@ static int scx_enable(struct sched_ext_ops *ops, stru=
ct bpf_link *link)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) !=
=3D SCX_DISABLED);
=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON_ONCE(scx_root);
+=A0=A0=A0=A0=A0=A0 if (WARN_ON_ONCE(READ_ONCE(scx_aborting)))
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WRITE_ONCE(scx_aborting, false);
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 atomic_long_set(&scx_nr_rejected, 0);
=A0
--
2.51.2
