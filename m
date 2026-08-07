Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091D38DC6E
	for <sched-ext@lists.linux.dev>; Fri,  7 Aug 2026 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066782; cv=none; b=Nd5NPtfe9UWSVvy5cNVuGtUJ7Zh+RtiemFYfP/qNeJPh80Xg7M1ixbOHL/lVqeK2+DRNfl/upNed1W+nfv6pagprmp02X0nPFYVjyxSpGK9g1Clj3qjtpfvPzv0x/hSo8briak0eoG1Mcv+XcoNQlreQMQ4h08O7AOQix7JWJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066782; c=relaxed/simple;
	bh=l/cl31CK/6KCMPe4n3HrC+no7IgTRJXI3vX8E3crt6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p52QyYcbTwUl4GiQahJc/kP8ZcTWh6ksq/EprvQxJZJj1FkXBF5VuoVNs4/LhUB95N5EMqfZnAjoi85Mu8BUdLd5G7ZFzVK2hO5Txer5qAwxvzwIg0VKSeKLDpoBx+JLjPz5F3vwM6b6ZWPwN0r4X+/fNVrbHnj+tB3NhEPD4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ce2d1a28920011f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cb9be6a8-3346-4db0-a416-e7a878075a96,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:86f76d6c2382be22c549ec570f552875,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
	|15|50,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ce2d1a28920011f1aa26b74ffac11d73-20260807
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 172554920; Fri, 07 Aug 2026 09:39:18 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] selftests/sched_ext: Check skeleton open failure in exit test
Date: Fri,  7 Aug 2026 09:39:12 +0800
Message-Id: <20260807013912.3178229-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

exit.c does not check the return value of exit__open(). If it returns
NULL, which happens when the skeleton wrapper fails to allocate the
object or open the BPF ELF, the very next line dereferences it via
SCX_ENUM_INIT(). That macro expands to SCX_ENUM_SET(), which accesses
skel->rodata, causing a NULL pointer dereference.

Every other selftest guards this with SCX_FAIL_IF(!skel, ...); exit.c
is the only one missing it.

Fixes: a5db7817af78 ("sched_ext: Add selftests")
Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/testing/selftests/sched_ext/exit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/selftests/sched_ext/exit.c
index b987611789d1..01b17092d5c8 100644
--- a/tools/testing/selftests/sched_ext/exit.c
+++ b/tools/testing/selftests/sched_ext/exit.c
@@ -31,6 +31,7 @@ static enum scx_test_status run(void *ctx)
 			continue;
 
 		skel = exit__open();
+		SCX_FAIL_IF(!skel, "Failed to open");
 		SCX_ENUM_INIT(skel);
 		skel->rodata->exit_point = tc;
 		SCX_FAIL_IF(exit__load(skel), "Failed to load skel");
-- 
2.43.0

