Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0B2BD580
	for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202648; cv=none; b=WeRbrMPBv0kORg9QLDjO4Lu/dvn675Ju7SuCT8Me8NsU+whq11f58n4P/SLQou94wd78tZCitrlUJfAczIlvMlX23B81HQztSlzvlqvxczyXGmN59jRcj8tmDhnDS6Xp50zA4j+6e+1KarTLF/jnGH6L9q+rQYwcCFSWooySRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202648; c=relaxed/simple;
	bh=b8KXgdkuB2rBCBMKoOj23zAGkLun2ndQut4LRQn9YLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs3r8pLOqDyikv9ez+ViPLGe/uyVvkOOXk4rtYOlaURVdY03zaFPpbvMD6G2YDcGyaYRt2WCFHhNVKrd59UorHCpsSg8iIJEdaA6QkvtlyAh820vwNz1Vsna0QqHwgQXmv7bMRsqzW4fziGjAQUBEAie9kAmQ8UefrNPUpt3sLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XLXGEjOo; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XLXGEjOo"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-644722d0b23so1424992d50.0
        for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202644; x=1767807444; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z65KNwFWdBB4vKMl4Q2RH4hcwYRlqC7hzCG8+fs8pqw=;
        b=XLXGEjOogyejmp39f8tvO02uTdlTVbBX5uMBv/x513fCIOShho17As+N2tbSFk1azN
         PRxeTKI9cujfk44rxCoqCQp3kpqkJ6EE/EmQBuDbsh5AQHcHk6TKozPonxszkP8itC3n
         D9jMlo9bqqMnLJ0EUdGbIEFF9yoINSHfBCX5W3jCL23ub2ztyvmrWIR/tsTaNcklte7u
         GKWF36ywcJXnzlG3b9srQbuzN6cqOzVw7fk1h7hzEB9vSqttkd2GJ81iJBpJmC2LNgbF
         D4pwoXOB5Zj98mXDU/JkSWrYpkWTEtFlEPNBbeBzq2KWm4lVqlzfP/ouRZBWaj8/G4tk
         +8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202644; x=1767807444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z65KNwFWdBB4vKMl4Q2RH4hcwYRlqC7hzCG8+fs8pqw=;
        b=IECB9le5lGDIDhyAXcnITuc9lTP5/oRY4wEPYirO/3i642yiJiOtLYECnlYjGU8qvk
         pzgEAuNJ5Vhd4pebzIwb0V/zpBZXU/gKq/f9ACjwnPeCrC6vBD8FWy1Km/+fcLCa3GHk
         1OsBl8zkYLOu1Cpnhi2CYaiwPzezj4vCzGuKxr7gRhrlKjbO4BgsfRx2dWw2RqyNd5Ch
         gaAhMpKr/2JdYLMOc87agGhUfzmoBVDzN7jmmbHwBGNQj2/jGmSyoVZtjWQ5dIZPLUez
         PSwKSDxj3DFRkd203TwDZ8PvAdHCWKWUhRLHIUyLqEoBNVzuKyUAWbrnT1kOcnCkAQmu
         KDsw==
X-Forwarded-Encrypted: i=1; AJvYcCVtkoMZDV7lLXra68BJJ7V2MCUApMhIUyeJmssrNwW7m+blXwAPplGwrlbo6sNGWPnHKYdeEmDx6bo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9e/URLjO7llfbtXyMFIsdkPTbdfEOwN7Ec+ZHa86lBTZw+XPu
	8DWhrk6D6mXPZbtzQQhzMlu4FcvkaSFOy70VNPVcTTKCv+3a541tHDig6Evyc1cnbtL3p9zOvKO
	FNYmcM9NvtbFrbGa/W5j4fLlo2IB6OJoaS29mnJKrZEc9eZf4kezE
X-Gm-Gg: AY/fxX6ajoBnE4HuOMiQXxml48U0SAx+ya2UKmOgWQV75DkLTi/pwldUM4rVncp9pOl
	NrzZOJUtDTO6pHM0v7QFdcCDbt9P8A5VBOZgtK7Tx8ZOtpCvKdt3vRgcXgdv3OxChM2iSH65m4r
	n4k95XThxj7SswX8j3zkj67Z3uWNSmFpsdAvvaufdIJeys9bj8F2eRCSbpnc4sbnFRYuorY7kJG
	cT5rEWzW3pFCkYd64cRlvIQ4GfBR+msfDLriQ/v7s3uKi2E1GbVfE4QEDActNH+S44LPhkCy+nk
	BfhJ5YUASj+tPiqczZiyBIaD9ql4zZCCfKXiwNM4ZESYCyxK1dIz0JkmXai9Awq3Swweexoi6+w
	g7jiwhb+ao3Lq4RogDhO/tesCHNM=
X-Google-Smtp-Source: AGHT+IEBotP5m1Z5wYbNapmTCc4dT38K0CaYELN4ShRlN7De1XjUql9tbwl7WLX8LVNM50Lf/6OW51/NhCsQ
X-Received: by 2002:a05:690e:c43:b0:644:7b59:4217 with SMTP id 956f58d0204a3-6466a87482amr25194896d50.1.1767202643755;
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6466a91dd41sm1876075d50.9.2025.12.31.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 291DA341C73;
	Wed, 31 Dec 2025 10:37:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 22C62E4234A; Wed, 31 Dec 2025 10:37:22 -0700 (MST)
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
Subject: [PATCH 3/5] sched_ext: make __bpf_ops_sched_ext_ops const
Date: Wed, 31 Dec 2025 10:36:31 -0700
Message-ID: <20251231173633.3981832-4-csander@purestorage.com>
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
declare the __bpf_ops_sched_ext_ops global variable it points to as
const. This allows the global variable to be placed in readonly memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94164f2dec6d..af8250b64f47 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5336,11 +5336,11 @@ static s32 sched_ext_ops__init(void) { return -EINVAL; }
 static void sched_ext_ops__exit(struct scx_exit_info *info) {}
 static void sched_ext_ops__dump(struct scx_dump_ctx *ctx) {}
 static void sched_ext_ops__dump_cpu(struct scx_dump_ctx *ctx, s32 cpu, bool idle) {}
 static void sched_ext_ops__dump_task(struct scx_dump_ctx *ctx, struct task_struct *p) {}
 
-static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
+static const struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.select_cpu		= sched_ext_ops__select_cpu,
 	.enqueue		= sched_ext_ops__enqueue,
 	.dequeue		= sched_ext_ops__dequeue,
 	.dispatch		= sched_ext_ops__dispatch,
 	.tick			= sched_ext_ops__tick,
-- 
2.45.2

