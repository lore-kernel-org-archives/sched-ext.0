Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7DA29A32D
	for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202646; cv=none; b=JP7WCDWHcH+At55rp8979nD8/rns8byjDUvrvPZeOU+Rge313Oums5EyxgWbOIHUaXNnkt9dE24uY26UbdDM8xYDhjBScfkPxJWhR6c+gEvtTMkQMtgqJqjvfQRyKdvPdXc8N0AowJM/Ji5nIYCHjVyvqpPnjDi3IjzcVKAaUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202646; c=relaxed/simple;
	bh=LZYOpaJobrgCoHjgtRl+RztH/j8GuhkRE/eHMkq8QYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVItizYtXO9YIlwvbHii/10XNowkvxpatadXVLZJ/t1ybRNIkcKShvfA/UsEHWD9PbCFKl7gX4dLrtkrkOpaA+AzJG/HdiU9vtVFVd3Ebr334J9j3KMO6veNyxdkp6i/gBwWUarhEYWKdQQB5ebDNgPrbWdhglyKyd3iJzxv5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RBs7s6E0; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RBs7s6E0"
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-b830b385507so85322966b.1
        for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202643; x=1767807443; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVlyjcKAentrmX30QVvO0mBVKIkrp0xM35G2rMEV4pU=;
        b=RBs7s6E0xMe9mFYvuS3S/WfrmWY6kL7Xixb0ZM4hiUP86SEX9zbOzEBcqea749tW8e
         GPEoXEfH+X4U/Kg+gj0G1bYchDqzZiDTJNsTElGhVgEeohbxzil4bETfBpUGzPSyFOr/
         ZzM4tj66R6HUEsts+gmpza+gyB4QpXcY8DpaR3pY0p3M8y3nGbRWO2zRLqhBEfdWhJ/R
         7tHXWAez3Kv/cD7v+Er1Tqe6uHChERUuzoJ7mzcpY/N/jELqI0Jtr4VvdNg9yq/QyneO
         GPih02zdgfzLEI4nFdW/lt7dOrJTl2VCkLnCHUqn5JmHappRvClHyetOcAVOjGCmgzfR
         ABpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202643; x=1767807443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVlyjcKAentrmX30QVvO0mBVKIkrp0xM35G2rMEV4pU=;
        b=GYjDK7xoHvyTWpojk/TJhVHt4sR0clyCxirDHC/EDSIUrjvSaw3utuTZJV94od0zO+
         pqpdcREy1jTH3iuiOPoVoHBwYMc804KLVHZY/VGUzw7D8a1J1lm92Mg5MRnafBpBQIOY
         /mnHH3e4AI0VbViUklioSfayejOWQj0Is0O+QUoIyYm/5FHsodwd+wX+Yq+pttgxQ2mM
         HSIZehYU6SuRaR0AfcXcz7ZXxmM7YeMitQi3heiZ+p5OUtP5oqdHUUg5bcyPy10fx5ZZ
         3eGzulVG0d7RPuSXVJ2DHFrRAFLUL/P9lvUdQ1riyU3VRQMcKs7yypMmvqEIBnUHE7HZ
         mJZw==
X-Forwarded-Encrypted: i=1; AJvYcCURAxi/N25u50PUpmR1+beQcHaHtOOd1ajEEvCeS5102H+1tnpoN5kqQvXTBN8CGSexXk/++Yg2v38=@lists.linux.dev
X-Gm-Message-State: AOJu0YyXaTZ/Qr9HIqRfBUkKTlTQ+zRug7RX4N6wenTefuPCy0srBUl+
	IC2j85z30s76NTL69Qg6rPuKNhnaLvaWugbraABE+aQtlCDR064wxY8j0IiP4Cuo5ehD5lE4LHX
	T1Y7LvTbnUgMbsR+eg+5NAQHLFof1yL/yagz3
X-Gm-Gg: AY/fxX5K3T3cAkTZvN3uAyl/dcVIVRJc3IYatNTyGZa8jU5nNP1L7UZN9WVocW9FSih
	A6bZwq28IJlSGU3myEpj622RWV35PJjvtuvrhXIO9k+eYQOeudb4QSZIAJ3hNCDgpIEaLbX4h+q
	O8Wa+OaFkunDTp5gsPc3wLXNmdMAG/Q3lqyj+5nvwCViBjlMldwaGN8smmOYZgcxxpYHRMTswo+
	qSyH2tqBBTxJXgOYZzaMlyjS3rkJKJo+Rn1U2kwcWv0rqxrcSEljPobN6500YVme1Gi6ucNkWGw
	+bijQGRtn01h4Ev6JBbAXnD5PiokwjJfk4/94xNgqkFeihFP2WCa79wiyl+Lr377HXeg8XBe+mg
	xWxkU7gHcD5ZOm6J+q4Zhx7WQDlDZf57g6uY9RZer6A==
X-Google-Smtp-Source: AGHT+IH0qj0xP8nn7XEk82bp25VPsAtCCWhbeDKuoNLXsuuLL96JLtHTE0PopXu8vpZIgfLz0+onnd2+/ts6
X-Received: by 2002:a17:906:9fc7:b0:b76:d7ce:b017 with SMTP id a640c23a62f3a-b80371858abmr2253623166b.4.1767202642561;
        Wed, 31 Dec 2025 09:37:22 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b831340b988sm264434466b.60.2025.12.31.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:22 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2F956340185;
	Wed, 31 Dec 2025 10:37:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1CE0EE4234A; Wed, 31 Dec 2025 10:37:21 -0700 (MST)
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
Subject: [PATCH 0/5] bpf: use const pointer for struct_ops cfi_stubs
Date: Wed, 31 Dec 2025 10:36:28 -0700
Message-ID: <20251231173633.3981832-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct bpf_struct_ops's cfi_stubs field is used as a readonly pointer
but has type void *. Change its type to void const * to allow it to
point to readonly global memory. Update the struct_ops implementations
to declare their cfi_stubs global variables as const.

Caleb Sander Mateos (5):
  bpf: use const pointer for struct_ops cfi_stubs
  HID: bpf: make __bpf_hid_bpf_ops const
  sched_ext: make __bpf_ops_sched_ext_ops const
  net: make cfi_stubs globals const
  selftests/bpf: make cfi_stubs globals const

 drivers/hid/bpf/hid_bpf_struct_ops.c                   |  2 +-
 include/linux/bpf.h                                    |  2 +-
 kernel/bpf/bpf_struct_ops.c                            |  6 +++---
 kernel/sched/ext.c                                     |  2 +-
 net/bpf/bpf_dummy_struct_ops.c                         |  2 +-
 net/ipv4/bpf_tcp_ca.c                                  |  2 +-
 net/sched/bpf_qdisc.c                                  |  2 +-
 net/smc/smc_hs_bpf.c                                   |  2 +-
 .../testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c |  2 +-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c   | 10 +++++-----
 10 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.45.2

