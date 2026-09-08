Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF21491590
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911778; cv=none; b=YbVsmuj/jD+RI3/az0PjfG6jWGBcACR5AnfAYisIrkq5jsakcKOmD6W6o5i3DD/4mNKB+HRA8bqkVVLRrgnN4Bc/bFLD9aSF0k4rmdE2zXIu9bBGxXpLyEBus7hUzMX1TshWr9ccFWtltRZ6Z6KvmM7q+4J3lAY8db+sBUbT65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911778; c=relaxed/simple;
	bh=5MxxvCdVgC3YLTJh7XEdP1bYFUpjHnVxjCwGvCeCFF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmh+E0z0dvljfAoCBFp1wirvhggTDhqW7i+ffYC4DjUGBMzAKh8W4rYmcQvbvD1JPF7oTHAZ8tGNIiKL26FUys+Hn6u5odgBVZP4OcX3x3eHGOzshdZ6u8Xl7DhR7F6aYXb/01ns25/TY239dCf0pNrqzNLruUM/J5dTRmiTWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwxiCWOU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwxiCWOU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso4417269a91.3
        for <sched-ext@lists.linux.dev>; Tue, 08 Sep 2026 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788911775; x=1789516575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aeaQ8qHK/MyWCciP9ARnOOzHBOTcOWNQ9SeCb5dOpCc=;
        b=CwxiCWOUA8a/lpKQKrc+wtPqdY3333v//qMRcKjUbCKBZBxJifDufCOaUV0RBd1dfX
         a6DZHR2WIl92EWSi4uVzRLTSeKqS6k/bwbJ66dHIunFUVKBKt4JK+Crv/NZmEHW+Ul/1
         UwxLk/jwMWIr8M7otDk+69F+Oel3FG2EY8y1uMGA7q4A98YuUnhSbfH/Koq8IOa/oxqQ
         DfuWLSDkJ8zX8Slg6p7NMC0eEtj5S5VJmTvTLf6xvtDw5yCIUw3YbxdaUWNEpBNpxn06
         qAJoQFt4sn6xsF3p9bpaAuwP1fyGu7OqEnPBhGaWu29bQwwsmdJhdTs6tuUzpy8pG6Od
         4eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911775; x=1789516575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aeaQ8qHK/MyWCciP9ARnOOzHBOTcOWNQ9SeCb5dOpCc=;
        b=DS3MvUW9Stt3pEGn4ytwEuadPOmnG2AdYafA1a8Ws6pu9SmomDrYcSRBLJThqRMS5/
         DfVKCUMGt7cESOI6CP7PfHhAIigCLWmeFxqSaLkyGoqvi7Oj2/TVPttGxBWvaM3S2Kki
         qojAkmGtR1NBPqBaUQXu4tYJElzW07wWziGCKLXtUfUUQn8aNkiJyHn2IEO5IMRaYs6x
         /hk1BeJvwk/jCImX7wvm7RuO+uSnGA4AjhMEeDWd/xqjuyhI8OxfOaPGdXvIh263gCnB
         +h8IdQ8KcB1TxvciXgL7xpMw6E7KLJYe7HAPyHkUa3c0W8+yWn6l0Ms09BzqvnW1pfv5
         OxdQ==
X-Forwarded-Encrypted: i=1; AKwUvByHDGfZEDaRvG2zDMNaY2uOiaMc+J9O0XYCDre/nSjsVKZg5mmfCQ2YRkH0lx3SCwdKqxCHZGO5wKA=@lists.linux.dev
X-Gm-Message-State: AFuF++m+GYrN7Wei7svYx6RicHjm7RXr1RhXRaU3IGjGT4NOJDVXCMgk
	OF4ekahUIM4Z1peXtcdbyPz7q/9MkPT6kD5OkNchbHb2FWoyPYcJUW3T
X-Gm-Gg: AYBFou0ag/npRCg93TnetJalTtgaKsHJmFMn5PyjyBWDtnQxekVh+cWMEU2BivptNUy
	Bcdt7DzbTukZUOE57HHN0NPUq/gGosl6GOTdZiOtEEgs+7pbIVhQvHPc+Gt9RwsCHQkMiaPA92z
	hUaI1LbPwpfS0cCZeRd0NXIcJwZGaHO3z+Ul0G54Yk4vMjGIPsoUxcTt/U34KOtCNCyYIylEben
	z/RrnjwP0VlyY+PQ0WuvaX1aNBcNkG+6StKMYJEK63onEyxC4jjf6eh01Mfqsw9itLpcYB3kOyF
	/rBnaDFCWTxRBnzxXtL2WInJPkKyH4FhAHKdq99p5VTToJA+7eDH4DYQCPo1/uKlQOFUWin2lxc
	6m0kh8wYxgWCiZ7F1SFzPu/eHdZxOE45Wdvezn3L1w6Iw407lqIXWxSQ3YIEUVgv1o17RsfYo/4
	XYVFG0IBnripVCLEwzfRH8MqMvQJKz8N4YEYvpnaVs6odpv9bAPcuInpE=
X-Received: by 2002:a17:90b:4cce:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-39b260dd4e9mr51323684a91.2.1788911775237;
        Tue, 08 Sep 2026 16:56:15 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:73::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm36459946c88.14.2026.09.08.16.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:56:14 -0700 (PDT)
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
Subject: [PATCH v4 0/4] selftests: add shared Makefile for BPF selftests and new memcg test
Date: Tue,  8 Sep 2026 16:55:48 -0700
Message-ID: <20260908235552.2610256-1-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the BPF-related build machinery that is currently
duplicated across selftests/{bpf,sched_ext,hid}/. It adds the shared
tools/testing/selftests/lib.bpf.mk fragment and wires up three consumers,
simplifying both existing BPF selftests and future additions.

The series also adds a cgroup memory-controller selftest that complements
the existing coverage.

Patch 1 adds lib.bpf.mk.

Patch 2 adds selftests/cgroup/test_memcg_stat_cross_cpu, which verifies a
cgroup flush by comparing values read through BPF memcg kfuncs with the
corresponding cgroupfs values. The existing bpf/cgroup_iter_memcg test only
checks whether selected values are non-zero.

Patches 3 and 4 replace the duplicated BPF build machinery in
selftests/{hid,sched_ext} with lib.bpf.mk.

===
Changes since v3:
For shared Makefile:
- Track in-tree libbpf headers directly so a single make invocation rebuilds
  BPF objects and skeletons after a header change.
- Restore the target definitions needed by LoongArch and MIPS cross builds.
- Validate output directories and skeleton suffixes, and reject dotted or
  hyphenated source stems before they reach build and cleanup rules.
- Add stamp tracking for vmlinux.h generation while preserving content-based
  header updates.
- Make skeletons and subskeletons explicit outputs, so a missing subskeleton is
  regenerated and both sets participate in the all target.
- Namespace private variables, expand the caller-visible contract, track a
  supplied VMLINUX_H, and remove unnecessary include search paths.

For cgroup selftest:
- Add CONFIG_BPF_EVENTS and probe every required kfunc plus the sleepable
  cgroup iterator before running.
- Bound CPU fanout, cgroup/process count, and total memory use; skip a case
  when the flush threshold would require more than 256 MiB.
- Check CPU discovery, polling, iterator creation, and BPF errors, with clearer
  diagnostics.
- Compare each BPF statistic against two following memory.stat samples, keeping
  exact equality on a quiet subtree while tolerating values that move between
  the two samples.

For hid and sched_ext:
- Remove unused HID locals instead of suppressing warnings, drop obsolete
  variables and comments, tighten cleanup, and correct the generated-output
  description.

===
Changes since v2:
For shared Makefile:
- Use USERCFLAGS and USERLDFLAGS to extend CFLAGS and LDFLAGS.
- Pass OPT_FLAGS/RELEASE and EXTRA_CFLAGS to the libbpf and bpftool sub-makes.
- Use one rule per BPF source instead of a global vpath that also affected the
  caller's normal %.c rules.
- Take HOSTCC/HOSTLD from lib.mk instead of including Makefile.include, which
  also rewrote the caller's AR, LD, and CFLAGS.
- Report a missing vmlinux from the recipe rather than at parse time, so
  "make clean" still works without BTF.

For cgroup selftest:
- Create one cgroup tree, perform one flush, then read through BPF and
  cgroupfs.
- Use common cgroup helpers such as cg_read_key_long() and values_close().
- Use cpu_set_t rather than manually allocated CPU lists.
- Move test_memcontrol.c's anonymous-memory allocator into cgroup_util.
- Address the remaining review feedback.

===
Changes since v1:
- Generalize lib.bpf.mk for source layouts and suffixes, extra headers and
  flags, skeleton suffixes, subskeletons, and configurable output directories.
- Add patch 3 (hid) and patch 4 (sched_ext), converting those directories to
  the shared fragment.

Ziyang Men (4):
  selftests: add shared lib.bpf.mk to build BPF progs and skeletons
  selftests/cgroup: add memcg_stat_cross_cpu correctness test for flush
  selftests/hid: build the BPF program via the shared lib.bpf.mk
  selftests/sched_ext: build BPF schedulers via the shared lib.bpf.mk

 tools/testing/selftests/cgroup/.gitignore     |   8 +
 tools/testing/selftests/cgroup/Makefile       |  46 ++
 tools/testing/selftests/cgroup/config         |   5 +
 .../selftests/cgroup/lib/cgroup_util.c        |  82 ++
 .../cgroup/lib/include/cgroup_util.h          |   3 +
 .../cgroup/memcg_stat_cross_cpu.bpf.c         |  95 +++
 .../selftests/cgroup/memcg_stat_cross_cpu.h   |  18 +
 .../cgroup/test_memcg_stat_cross_cpu.c        | 755 ++++++++++++++++++
 .../selftests/cgroup/test_memcontrol.c        |  29 +-
 tools/testing/selftests/hid/.gitignore        |   1 +
 tools/testing/selftests/hid/Makefile          | 179 +----
 tools/testing/selftests/hid/progs/hid.c       |   7 +-
 tools/testing/selftests/lib.bpf.mk            | 321 ++++++++
 tools/testing/selftests/sched_ext/Makefile    | 149 +---
 14 files changed, 1382 insertions(+), 316 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/memcg_stat_cross_cpu.bpf.c
 create mode 100644 tools/testing/selftests/cgroup/memcg_stat_cross_cpu.h
 create mode 100644 tools/testing/selftests/cgroup/test_memcg_stat_cross_cpu.c
 create mode 100644 tools/testing/selftests/lib.bpf.mk

-- 
2.53.0-Meta

