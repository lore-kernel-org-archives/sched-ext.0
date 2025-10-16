Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D6334681
	for <sched-ext@lists.linux.dev>; Thu, 16 Oct 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638333; cv=none; b=I+eLXRM0daAO5yI/dVkv88p6c09qFzp9RXp87hx2+lxHld6ruw6BPHKkMSrxjR35o47ZSDpJkGq3wWkLhecoMnrzaN07idU1aQKTtd7SPpvAgpOD+3fvPYHpkAVY/C+zsXfJECsxlkkxQCjbXz6rwWKaBaZoAmb8LE7GLvNeLKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638333; c=relaxed/simple;
	bh=97uDe6Y3n9I7LAc4RteqqzZHzMaVP+cNaT+IwPj1se4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LXNxLCqvg8RGm3NiZ27VUTk/ceSOuLiDBqSuu5dRy6+mCINw5PmM569905QaXywowBDG4nNMP8z9qxaUhW6M0FngDdxmfclWqRR4RsX0xAKYpASKxfRmhTTq/1isqkL7H3bB1d9FavnMCm0mJ0N0ATYpcdgZ6Dzj7k8h5YP8Wlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KxRtx53p; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KxRtx53p"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GEYmdt2401083
	for <sched-ext@lists.linux.dev>; Thu, 16 Oct 2025 11:12:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=+nOgVzVOE7W89h772Z
	esAi5kat/WKfyseDwcxwIe7ew=; b=KxRtx53pL5LO8DklSXGr9mVDXYoOOgRymO
	FGlX3Humx2QXmlGodG1tzgg23JTwgXy9BOTm6YXom7WYMWNUdmCVzsGc2B7j/vkd
	hsn6ynBYxB8MhOHQnMqIR5UW42Pq7BJxnTALICX6TsPotSO3fnUuFu2HbgdfAEyU
	HTL1Nr/NWt7h4Rk5upDQHzSwfh3C436N9iZ2yoKwktshTvkOlHek0j4CCeYgvCRT
	FSeP0uRugTsKquslpG/E9xrxaFTh/dlgrqDZP7l/ihCTROMU9CXy9wEIgDE25Ktu
	npF76iq4vOuAnP0Ng/tyPQumNeHUXcyq/jEcWlKJKRjWdy+FGjeg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49u2kfa2hu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Thu, 16 Oct 2025 11:12:11 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 16 Oct 2025 18:12:09 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 159299651AF3; Thu, 16 Oct 2025 11:11:58 -0700 (PDT)
From: Emil Tsalapatis <etsal@meta.com>
To: <tj@kernel.org>
CC: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
        <sched-ext@lists.linux.dev>, Emil Tsalapatis <etsal@meta.com>,
        Emil
 Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH] sched_ext: fix flag check for deferred callbacks
Date: Thu, 16 Oct 2025 11:11:26 -0700
Message-ID: <20251016181125.1482502-2-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzMyBTYWx0ZWRfXw1k4v3PFxNyb
 u7Vwi6T25xsMA22BFAxoqK1Ze9az3qRHCvNLGqlxnRdFyVBMyC4CCGReQKetd3sDihoBLxtI9lE
 q2g7ggic2NbJmOwk6ooE76dVKzRkvdYa9AnNCdDJYB5LpME9jHPEqgIJbyps1RR5HvpFgfQas4j
 iyYvGkVv9jBQF1at7o/AN5VEc+ol+NadGDsH38nwJjRSLckKNFSwB5yARIYnnfUga4FwCmlZhLJ
 jVyCF9N7gekv4Md5YiBVFX6yCf5PBNSRtAN4JJTVWkNGduE9BE3TrYytty5tTc6tZaNWNTP1rUz
 K4rwFN7DKa6rG2mOd1TVdWVrLHJsTJqOqC6cECYcYYVd3WzPR5kjT8oe3Xenw1ejl7/B9T4SvJv
 Nr2PQh7Fz1Af1oI4T09Nwn6wVL1lzw==
X-Proofpoint-ORIG-GUID: K0k-W7Yvknb8kgHqS3cT5m4MtIGQ8moY
X-Authority-Analysis: v=2.4 cv=Qftrf8bv c=1 sm=1 tr=0 ts=68f1357b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=6iNvn9odyTASpx3qGkIA:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-GUID: K0k-W7Yvknb8kgHqS3cT5m4MtIGQ8moY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01

When scheduling the deferred balance callbacks, check SCX_RQ_BAL_CB_PENDI=
NG
instead of SCX_RQ_BAL_PENDING. This way schedule_deferred() properly test=
s
whether there is already a pending request for queue_balance_callback() t=
o
be invoked at the end of .balance().

Fixes: a8ad873113d3 ("sched_ext: defer queue_balance_callback() until aft=
er ops.dispatch")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 12c9c3595692..ecb251e883ea 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -792,7 +792,7 @@ static void schedule_deferred(struct rq *rq)
 		return;
=20
 	/* Don't do anything if there already is a deferred operation. */
-	if (rq->scx.flags & SCX_RQ_BAL_PENDING)
+	if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING)
 		return;
=20
 	/*
--=20
2.47.3

