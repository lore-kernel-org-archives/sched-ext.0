Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E540911B
	for <sched-ext@lists.linux.dev>; Mon,  7 Sep 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763805; cv=none; b=LLOD36/RKDg1m4tOkNFO2e5ypdg7vmsfy1Ep6BBXavHcx/pBDuz4LILHOTBg38OYqLsBGC4kBCs0uwXC9RsH4AmiSQIZrpqpZ9JUiSjuhSeo05PFzh27ZlcCjV+BlpwAdETj9eLbbl67gO2OYIG6/CmOfL210gKhy7dnjljRJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763805; c=relaxed/simple;
	bh=GnAHVebleQJJnmt8WC+Szgot5FGZ67IN3635nKxQqYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/JKtkEb0/Kc5b5PQeviu0EtQFRu5qPmKOwFJclaEs3nTaxQXtXOdWBHWWw4h9D08g5bGAmqqpPGDCg5W5FwD6CxyUpEwRy08Nid915itNP0ELjD1bPDp6y9PGMhxqPg5yUVhNo0N10z1T6Ir3ymSoF2eym9fZnC3dPToXY1FmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTAYQ8CM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTAYQ8CM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8541875f596so1032314b3a.0
        for <sched-ext@lists.linux.dev>; Sun, 06 Sep 2026 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763802; x=1789368602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcyHQ8J0eTBJ6x/cyto2HEpUStNZUbDWvhiih6YejS8=;
        b=oTAYQ8CMBlcMu9+COa9RsEGNGrprD8S3zRLiovxJ+gkK3P6gFKv7sS3fw6eh7txe68
         8I2ucgROkwAzuuo19CT9LpO1Cnx0MYdjbMxAXsewzMlzd56pd6KNkGtwzDMM55QyQQ7N
         Ht2DEPsTngvrF0RUy4vWownkEv8e5oiuO8CUh1mPDzMPFEpjkfw8I+KJb2gaPEAbuMEq
         k6mYyFdpobVbMuKLvQPV2qU06btpSeG2zRqMePHj4hP8bKdOQcLkcSlMoxH1czyEjvvM
         EW0tV+FyweVeDvhJw6CHJoX2phD9jn+EOTLVV8E8MEdkLVE23R6BJ1z9/qZQOjsNWmZF
         V/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763802; x=1789368602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcyHQ8J0eTBJ6x/cyto2HEpUStNZUbDWvhiih6YejS8=;
        b=snWHEBQJMS1kA9ZP4dMLr5uwHZsAK1pocgjXMlQhK7yWwWRnfjwyUHPslnOGFz+sw6
         SLq1D9co+QLkl4p+RoDUD+KtNE/8RYVlG52Fws4RTwO8FeW+7bg0x+6MBRkdjh7M4/Fo
         UngRX0Bowm3X0HpAFSzSClbdR0dTffyykwHwymeZMfomboGhFuFXRMbX+smtnN0mrbCw
         +p6sfDYGn8c++GmyeEdR24/y9EL45HEfl7WF6iD8TT4NkdGf5a7LjGve/KF8KZWbTonI
         XcZSpV5sh0y2xxsmSeV6rqwGyPIwOelps0tphTRtzHTFm2LQJNHafFsURcsKxQAoZIe9
         735w==
X-Gm-Message-State: AFuF++lohrW6WKuZ0bRF5gSe9pk16L7xdAwHz1fnNOPZ0xL/X0b5jEVO
	jYHrWtbyMoEqGlsIJ54cHxa7j/g8Fw0xrV79XwmaDdeTWBBnkCkL0x6h
X-Gm-Gg: AYBFou0edaaJQHXgRUa4ch5Xdopk1t6/mFUiOP6QyclTf6xHvcebOUA2T1QsKWqQnvv
	p2xLdcL9l2l4P/4f718iE5r9txgeAzNmDSX1JnhCG7kC4BSra0eCc9hqvccOlkm1tu6TAbOPz3o
	lsMFUJup7W8HqR1RVwjW9vzI8hnHMoWVoQEEjyFplojOuv6dT02nCfRa2ErfOGpm/0oyNQpWVbt
	S01Ay3sIf4g5eXG4w3W1V3om7ZtTVcYTrE36zOo1huO0fJqkcuAn680rsRQx+Ivz45iELNz2ZeF
	0FzRVPyGRIewrQGF1gxzc9qalVp8tPSiqR2pOnTYafiptml7jChp1VVC9z6+OizflCf2+g2z7Lr
	o/XbdJwPbqa/YBTGzrcPJ2KdjURU8WOU0bBG9bvvfQF/sXlfW60ibXX/AokZg4nZfjo7WEVt1yU
	tSFJ5pwB69YxOZORWUVptbYFUVr0j7IJ7QHYz8jxPHA5YBcO/OfoiEdW/hYvKy7A+4nMGNp70Ag
	po8sV44OfndsA==
X-Received: by 2002:a05:6a20:5681:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3da39eacde1mr33933937637.4.1788763801799;
        Sun, 06 Sep 2026 23:50:01 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm465210eec.31.2026.09.06.23.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:50:01 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/2] tools/sched_ext: fix repeated word 'be' in comment
Date: Mon,  7 Sep 2026 12:19:43 +0530
Message-ID: <20260907064943.25304-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064943.25304-1-hemanth.selam@gmail.com>
References: <20260907064943.25304-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'be', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 76f5e025e107..9660b43d612c 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -306,7 +306,7 @@ BPF_PROG(name, ##args)
  * Similar to MEMBER_VPTR() but is intended for use with arrays where the
  * element count needs to be explicit.
  * It can be used in cases where a global array is defined with an initial
- * size but is intended to be be resized before loading the BPF program.
+ * size but is intended to be resized before loading the BPF program.
  * Without this version of the macro, MEMBER_VPTR() will use the compile time
  * size of the array to compute the max, which will result in rejection by
  * the verifier.
-- 
2.48.1

