Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D929A309
	for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202646; cv=none; b=IfkxM+Uzn5yYVKYaV57voOVpLzmSgNV60YWOmRIaim67kcCVAxYTdaTu++AR/Y9w2Xdc9Po6tdUmyDTpARja6jLVNnixF9WBXSXxbpznplWlkmDjla8IWra1K+oS2F+nXqlT3ZzS0BHpjgP29oWNAOlCq+MV2JVHNfYkDaZF3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202646; c=relaxed/simple;
	bh=WVYQGhpSvliDxHIS3oLwubflGM55eX6MoNuxuho0+Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6eA/v7ayweXOSe1Q22bui+Boln+3gok7F2WAuE7BGoGDJluIm8JAJDNHaMLXld1eLpdX5LJWPY28iqnDBnoyxX3Rmbn2fajKucJNnt6SC4pRKwPh6RBWpNsYQRtiekAXNP6YWpNQ88bQM5L4abetd3UIPZ7ePu/o0RxLK3JxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dgWhBu7S; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dgWhBu7S"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-29f3018dfc3so33333925ad.0
        for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202643; x=1767807443; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPtJoM4BdsW1AWCT74nIdjccEavCkJ/nIFp8Za4jgwE=;
        b=dgWhBu7SMfr9Mly4FdYum8hDE12XUSsjyYgoQNcBFeCf+y4adq01Q5o2SYFJJPn92m
         HAC0hYzBb9t6u7bdSbvf5NdxsyfYKQQwMVorlYLs48HpiQK9Bum4tdGU3y9/3XK7aI9o
         dsNSnXTc15eH+5bGTuHl7sZQKd5sBRtmMAaDP0F0/kJOWVpnRFE2mRupwy4kzinSqA3r
         CHCMS+eLYSruaYRwi7TgpQADGGKQKK8uzUMsj02mdp5tq3C4SX//bub+5c5sM6P2fyok
         HK1sWy0jVAG3SI7O1bSMzJ6amEpi2FZQJg9wz90J2ZH8Nq4fX+ogm/XfzqLfnafB58AV
         q1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202643; x=1767807443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPtJoM4BdsW1AWCT74nIdjccEavCkJ/nIFp8Za4jgwE=;
        b=KpT1DuKfy6OPOwsS4Xmp6t1eDgnK4tbp5uNmIuLda/EZeqaVwCn0yQdTBj2R/777to
         oZ6GwUMHCh3ZZA/NXDiBdzlz1aADsoKbXdUxQJ1PQdDORT9SPPeQg4nFSpNMGrWEbhX/
         tE3PbqnL+rKH3dPdQxcQ407NmtCLf9f/ft44UicBW/Rab2bP8Q9mF59H0/nWONuDdbNY
         mknbxZTAkP10oxK1sx8SD1i8hCBhXC1m33sPipup90dd0vSwMLVlGcDXzQfGi70XVKhe
         aYS0v0GTATfF1A1TSvqW0k0BFqJPlqVg18BluXmEDBxAVCs7NC1ywpqLMW8/3+/P5Pm8
         9u2A==
X-Forwarded-Encrypted: i=1; AJvYcCWYi/vYxXL04bSGgAgTPH6XFtT7lpQQIBVxDux5VG59ISM1ZRdFN6mAV+3KGrlAn6J5vwrLCA8wR3Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YyEVjfis1i4OVqGw/bvHpNndMJN0AL5BYDKR2vePLzbS5vJ/K0x
	QnCBl65oMASmf0jBx++QNpIbC3Y3/qkqJw4X3FSf4lFl2Tk5D2+RJuTOqyI4CMegPTYixqxJNhT
	VwGsQFck9UjFBdYC2NEEtC8qIg+2h+ityRUR+HfxAl+6rL/VFlWTq
X-Gm-Gg: AY/fxX4O35YxjPDkowqDILq+DfSu+0pE7B1xq/64WYCjKe2OY2K0awylz2b6nDf+yBg
	5VTHD/lnj3EyMJ0BzaHlYBNlBZzs7MPMkzQflMK7vXIYEDj7cOPSmHFU6QVwdX9BhngQb+i29f2
	LGO3sq4qNPbgEhSbw9EBBa+1UfJsuqG7YeWtducsyyXrRfhVfCjXfFCg+0IXVZVeYfNjbmHeM22
	kqBFjzGoTcyrfwwEKy7NTrSr7oEFlgKSSKpPyuPCUntOLTEk+/ngG//EBeWvBblzKEHPqE5gAVi
	84mQQaKpC7QIL7nzTnjMT1nxdYSon30No8JhDxt4Jhr/ZsTFFk3OvbWzXrtmNaRsyghNfXNH7J1
	1QPAva/+hvAhfYs7r69sVcAFaC0w=
X-Google-Smtp-Source: AGHT+IE/GKsBsuibLffcNY4jnMOysc9JCkTPS2IwqBtEufH6X/186Szw2JKOD3dV6u7dyuha2hnOZCCfweaH
X-Received: by 2002:a17:903:41cb:b0:295:745a:800a with SMTP id d9443c01a7336-2a2f2204346mr260754775ad.2.1767202643449;
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3d06e23sm40792255ad.35.2025.12.31.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA55C340879;
	Wed, 31 Dec 2025 10:37:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C307BE4234A; Wed, 31 Dec 2025 10:37:21 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/5] HID: bpf: make __bpf_hid_bpf_ops const
Date: Wed, 31 Dec 2025 10:36:30 -0700
Message-ID: <20251231173633.3981832-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_struct_ops's cfi_stubs field is a const pointer,
declare the __bpf_hid_bpf_ops global variable it points to as const.
This allows the global variable to be placed in readonly memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 702c22fae136..30ddcf78e0ea 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -286,11 +286,11 @@ static int __hid_bpf_hw_request(struct hid_bpf_ctx *ctx, unsigned char reportnum
 static int __hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, u64 source)
 {
 	return 0;
 }
 
-static struct hid_bpf_ops __bpf_hid_bpf_ops = {
+static const struct hid_bpf_ops __bpf_hid_bpf_ops = {
 	.hid_device_event = __hid_bpf_device_event,
 	.hid_rdesc_fixup = __hid_bpf_rdesc_fixup,
 	.hid_hw_request = __hid_bpf_hw_request,
 	.hid_hw_output_report = __hid_bpf_hw_output_report,
 };
-- 
2.45.2

