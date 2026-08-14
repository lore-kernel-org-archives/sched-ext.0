Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085283E3DB1
	for <sched-ext@lists.linux.dev>; Fri, 14 Aug 2026 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693877; cv=none; b=Vn7QK7h5K4xAx0bMoWMwEophsts0l7ZPtlvawHfOjbcyv3esYYhxtgThPaoHV0KA1GGtSWQZTdzIG0Bq2R8pqNFTCHUCq76CtwDkl6CPXvOQlY/N8MJs2tVxP92ndkN5vjNydLrKTRFSTBzZ8wVGeSBKwO1yuahLHo0jX4dWD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693877; c=relaxed/simple;
	bh=vGb2AL0Q+YFnzB3UTu2+t3nWJA5Bw9JDxdRJVkur5KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIWBtGF9vvbELwg7yLQDcDUeNSiDTt2BkbQUyoGtZSQJ3J/df1fKLFCzY1Ku6zQEXDQx3PJJOLh91oud1828dcmdEJrMVQtMb9UR9O+aumLFUmJrCPyQjZ+x6qGwn5xZPptiIHAbNCCQwI7+G0LiE5PneaWTgUB0tdrdaa1TKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUzUmNpO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUzUmNpO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so10806345ad.2
        for <sched-ext@lists.linux.dev>; Fri, 14 Aug 2026 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786693871; x=1787298671; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7NJF3oq4Hw+2dLyF07fyfL2A6PD1tYu7/+/ryOQgrk=;
        b=TUzUmNpOMHcTlIx7i2AG8dCBcx5t8nwsGnBB8GnxWtxKEDtXxmOMpY27L3uIaye0dv
         kIF0F1oMcsF8snGthxY3hTbOLfohMKbB7jiBe8003gVYHh6MzyCiwUAjaeaLyBF3Q4fc
         DaWcDZiRccBX4hUDmx4jZWOG+5xfNsaoIR0uKFmtnol4QsnT7rD2dTwtkW6m3w5g/1V3
         FmABAANipTIN8JNzuKmA3dQG6/Rf99GMdI4mhavabNP2ffgvUh5ltWXqbSD/dzu9S+Rd
         CBzNOO21V219/3idB+Y2neBWx8vVsYO8yS0/SIz9SBVWn5YyrSq3f7Zr+O1CiI42BS5/
         ohdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693871; x=1787298671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7NJF3oq4Hw+2dLyF07fyfL2A6PD1tYu7/+/ryOQgrk=;
        b=GUlQyL5/LrcILO8u2BEULKoXooRCed6hqnm+1nwwqY0DlysCf4NJjtiH6yXpbKt6aO
         Yz6CI08ccmYLERw/v4M2SFZcO8NSier6FCOPrNJ+QZxf31Tdp2ujdopBZ9x/iKFjWtEo
         jhHt73F+jkKTONo3ES8nkZruhKZGgKDPdymYaJDQfxLGVlFAY5klGCNfFuAwWFRGuqkO
         7IJDd1QPtEj9zHcNGXfB0njGEthWI33fC2agw6DEnbOQggM9IOpir5XHeKFE883mh+8L
         I3G8xNxuyLkmKsxRuJEyPlgA02XMBJmTVXv1pQ0ED3TkP1ebTbDpqeSULdwdS0B74NeL
         Bubg==
X-Forwarded-Encrypted: i=1; AHgh+RqIWvziT7bpkHsNUyS83FzAVdlMopdCneSm2285fxr7yuCW4uWqyoXZ8PN10dtU8ekgCqKwyUYea4E=@lists.linux.dev
X-Gm-Message-State: AOJu0YxE1eALXO3154PmmGWVi8CgGLE/y9otR5E0P8LTORL+aFp08eKg
	x96T/epD1rq9QPQ1rdPRY5fMnZzgMnghA+a86eQKKRU05QCQ/1P8VkRc
X-Gm-Gg: AR+sD122YAQnKaqdnGJyz5iFwzX7si4fRnF7Hoo9R5KxFccSN2Ebou1Fgr1Xl91WJVd
	AzafF+33dTH+Q1XAHTnWpMGr+OzivoJ4v8LxrKxr0EsUPhvSeP9G40PnaaY51W0pTOv1bMcujuv
	H/vIrLIvD5scw3dT303W/EhSaJPJPqLv31ZGmj1SaGqO10BPdBMBNX8kOiotspxao1Pi846jNMd
	HYsKbush6wM6d6li3c/7ALDCPaspwMHnaNFkCdcYFUx0PR5BS2Jl5aBY65THr5chO7WlTZt6AQQ
	IsRkfIKmFLTNEXBOxztNdvDJAXQHQIOnh98rhdgxstBQJBo6BVM5oUUG6PSiuLSGZWlVC2KGSvI
	T8CFIWT3isVUWAlm05I9j9lv65cn70lmnsBawFjzuxVv7fCJ838T4h/a18VZ/YJ7ZtZBoVpWtYm
	LjCUrBrBqGvJr/vYLPAAc9+mXHa3hEbHwCHZqPXlMc0Gxa/F4sbL7DuGAMolwj92MerPFDbDysn
	GgQ0A==
X-Received: by 2002:a05:6a20:748a:b0:3c3:a9e1:a819 with SMTP id adf61e73a8af0-3cc71fb5781mr4100219637.24.1786693870755;
        Fri, 14 Aug 2026 00:51:10 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:68::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm9201342c88.6.2026.08.14.00.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:51:10 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Vernet <void@manifault.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ziyang Men <ziyang.meme@gmail.com>,
	kernel-team@meta.com,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] selftests: shared lib.bpf.mk for building BPF progs and skeletons
Date: Fri, 14 Aug 2026 00:50:50 -0700
Message-ID: <20260814075054.507089-1-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series re-factors the bpf-related toolchain for selftests, which
currently duplicated across selftests/{bpf,sched_ext,hid}/. Unify them
into a single includable fragment, the tools/testing/selftests/lib.bpf.mk,
and wires up three consumers. We believe this will simplify the work for
configuring selftests with the bpf, for both the existing and future ones.

Patch 1 adds lib.bpf.mk mentioned above.

Patch 2 adds a new selftest, selftests/cgroup/test_memcg_stat_cross_cpu,
which checks the cgroup flush happens correctly by comparing the bpf
read value matches the file reading. Existing test
bpf/cgroup_iter_memcg only ensures whether the number is non-zero, which
is trivial in some cases.

Patches 3 and 4 replace the duplicated parts in selftests/{hid,
sched_ext} with the lib.bpf.mk

===
Changes since v2:
For shared Makefile:
- The lib.bpf.mk now use the USERCFLAGS (and USERLDFLAGS) to extend the
  CFLAGS and LDFLAGS. 
- OPT_FLAGS/RELEASE and EXTRA_CFLAGS now reach the libbpf and bpftool
  sub-makes as well.
- One rule per BPF source instead of a vpath, which is global and also
  applied to the caller's own %.c rules.
- HOSTCC/HOSTLD come from lib.mk instead of including Makefile.include,
  which also rewrote the caller's AR, LD and CFLAGS.
- A missing vmlinux is reported by the recipe rather than at parse time,
  so "make clean" still works without BTF.

For cgroup selftest:
- Only one cgroup tree is created, one flush is performed, follows by
  bpf read and file read. 
- More common cgroup functions e.g., cg_read_key_long() and
  value_close(), are used in the selftests.
- Use cpu_set_t rather than manually allocated cpu lists.
- Use test_memcontrol.c's anon allocator and moving it into cgroup_util.
- Other suggestion from the review.

Others:
- Bot reviews are fixed.

===
Changes since v1:
  - Generalized lib.bpf.mk (source layout/suffix, extra hdrs/cflags,
    skeleton suffix, subskeletons, configurable output dirs) so it can
    serve hid and sched_ext, not just cgroup.
  - Added patch 3 (hid) and patch 4 (sched_ext), converting those folders
    to the shared fragment.

Ziyang Men (4):
  selftests: add shared lib.bpf.mk to build BPF progs and skeletons
  selftests/cgroup: add memcg_stat_cross_cpu correctness test for flush
  selftests/hid: build the BPF program via the shared lib.bpf.mk
  selftests/sched_ext: build BPF schedulers via the shared lib.bpf.mk

 tools/testing/selftests/cgroup/.gitignore     |   8 +
 tools/testing/selftests/cgroup/Makefile       |  52 ++
 tools/testing/selftests/cgroup/config         |   5 +
 .../selftests/cgroup/lib/cgroup_util.c        |  83 +++
 .../cgroup/lib/include/cgroup_util.h          |   3 +
 .../cgroup/memcg_stat_cross_cpu.bpf.c         |  86 +++
 .../selftests/cgroup/memcg_stat_cross_cpu.h   |  21 +
 .../cgroup/test_memcg_stat_cross_cpu.c        | 596 ++++++++++++++++++
 .../selftests/cgroup/test_memcontrol.c        |  29 +-
 tools/testing/selftests/hid/.gitignore        |   1 +
 tools/testing/selftests/hid/Makefile          | 180 +-----
 tools/testing/selftests/lib.bpf.mk            | 296 +++++++++
 tools/testing/selftests/sched_ext/Makefile    | 146 +----
 13 files changed, 1204 insertions(+), 302 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
 create mode 100644 tools/testing/selftests/cgroup/memcg_stat_cross_cpu.h
 create mode 100644 tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c
 create mode 100644 tools/testing/selftests/lib.bpf.mk

-- 
2.53.0-Meta

