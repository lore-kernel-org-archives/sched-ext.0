Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943341;
	b=5BtGTlRGcybWKeac3XtOXrvLsTCJou2Vj3hK/pNe6UNEDzLMw+MT9P6g2a58hyGlFjhq
	 EVhbN5tnrcwXQptBhkxU/IxD5RGRrWYLJ5LOwACGo5ZMR+3aifVDoc3kbdogh1IAEjaAl
	 62jETM/EhcXA0mE/WMUtTTspHr1kItUad0ynbCq1IdxpLjmO7nhATeb6i2HuYXrfQXQQp
	 tT1Ags8+eRLSZ7w4NO37DFDGTPYQkEVjPUsP3zHkoNoMmZArZGdxFNxFNcWFJ5hDRD+qX
	 SMc1rANAS5+9QSMxCr9PzSiXdF4XEDg9mXteVpO5rRRtqHp+lu/b2KZvpVEI+Gb4w0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943341;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=na58Fm3qQJWxjZpHDb+T2K0Z8/nj9eqBuy4fDu3CYcg=;
	b=MA2+BVwZs620dOFmDGErdz5jRMPbyLawWIgREpsCqxtTfv99Zr+BP4iC6eUtZFL3S3/y
	 86dfJuWOvdSixGwlzdk3Q9L25fcjKAYqxWFervC8SPAbVa4M+hDr+HfyfNIMQvqt+BvG8
	 CiHWZS2ga2zEKb+3EitAjCje8L9RJQQ14HCbdEtbHbyGImC8ovRSUYnHi0M5b/3ONzw+h
	 Y9w4WtZmz+NPwYulepluxqdu25j9ac3bcc/IBOZHUHTKTZuTND4DaM6Y/l8EwhPRLIa36
	 1YyPU8ijZW4L+bG2nWyUr2efqtWZIUReiqYdWuLyRpiyuFPXmpy6E77WUS8Bgo1CUrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ig5nhA1g;
	arc=none smtp.remote-ip=95.215.58.190
Received: from mta1.migadu.com (out-190.mta1.migadu.com [95.215.58.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF3606A880
	for <sched-ext@lists.linux.dev>; Tue, 17 Nov 2026 19:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3CF3606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ig5nhA1g
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Y87R5DnrFIh3i6HvyMFMZq0wFUiBP8SOTAQOEjOaBb0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794943339; v=1; x=1795548139;
 b=ig5nhA1gMCSvwK/QNQIEZWbB0R3kZzzfa1Elypb2KkMIMIZG1t95gJmuPue0lxYBfiGKvMnM
 kYdbHM6FnEyvty18ce80fqXxZjTT/zL69q/wRwgyLsObt5EGFdbBH2EjR8X56g4HVbBhIMxFBfH
 u5CcSopFm7xTSr8+6TNhkLzw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id c424a9e1da33b619;
	Tue, 17 Nov 2026 19:22:19 +0000
X-Mizu-Trace-ID: c424a9e1da33b619
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 4/4] docs/bpf: Describe how to change a kfunc's prototype
Date: Tue, 17 Nov 2026 12:21:53 -0700
Message-ID: <20261117192153.3384031-5-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section on changing a kfunc's prototype to the kfunc lifecycle
expectations. libbpf now falls back to ___-suffixed kfuncs and
resolve_btfids rejects kfuncs that libbpf can't tell apart, so kernel
developers can keep BPF programs built against an old prototype
loading, provided they follow the rules this section describes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c7da603cab77..17043ef15da3 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -800,6 +800,89 @@ procedure is followed for removal:
 3. After the deprecation period the kfunc will be removed. At this point, BPF
    programs calling the kfunc will be rejected by the verifier.
 
+3.2 Changing a kfunc's prototype
+--------------------------------
+
+libbpf binds a kfunc by name, ignoring any ``___suffix`` in the BPF program's
+declaration, if the declared prototype is compatible with the kernel's.
+Otherwise, it looks for a kfunc named ``<name>___<anything>`` with a compatible
+prototype.
+
+Prototypes are compatible if they have the same number of parameters and the
+same kind (integer, enum, pointer, struct, union, ...) of each parameter and of
+the return value. A pointer's kind includes the kind it points to: ``int *``
+and ``struct task_struct *`` differ, ``struct file *`` and
+``struct task_struct *`` don't. Integer sizes and signedness don't matter, nor
+do the names and members of structs, unions and enums. Typedefs, ``const`` and
+``volatile`` are looked through.
+
+A change that keeps the prototype compatible, e.g. widening an integer or adding
+``const``, is done in place. Otherwise the new prototype keeps the name, and the
+old one stays available as ``<name>___v1`` (``___v2`` for the next change, and
+so on) for a deprecation period, usually as a thin wrapper registered with the
+same flags:
+
+.. code-block:: c
+
+	__bpf_kfunc int bpf_foo(struct task_struct *p, u64 flags)
+	{
+		...
+	}
+
+	/* bpf_foo() before flags was added */
+	__bpf_kfunc int bpf_foo___v1(struct task_struct *p)
+	{
+		return bpf_foo(p, 0);
+	}
+
+	BTF_ID_FLAGS(func, bpf_foo, KF_RCU)
+	BTF_ID_FLAGS(func, bpf_foo___v1, KF_RCU)
+
+BPF programs built against either prototype then load:
+
+.. code-block:: c
+
+	/* built against the old prototype: binds bpf_foo___v1 */
+	extern int bpf_foo(struct task_struct *p) __ksym;
+
+	/* built against the new prototype: binds bpf_foo */
+	extern int bpf_foo(struct task_struct *p, u64 flags) __ksym;
+
+Only libbpf 1.9 and later look for ``bpf_foo___v1``. Older libbpf and light
+skeletons see only ``bpf_foo``, as after an in-place change.
+
+Two kfuncs whose names differ only in the ``___`` suffix must not have
+compatible prototypes: libbpf couldn't tell them apart, and ``resolve_btfids``
+fails the build. The one exception is an alias of ``<name>``: a kfunc with the
+identical prototype, parameter names included (BTF dedup compares them).
+
+For example, this widens an offset to 64 bits and keeps the old prototype as
+``bpf_bar___v1``:
+
+.. code-block:: c
+
+	__bpf_kfunc int bpf_bar(const struct bpf_dynptr *p, u64 offset);
+
+	/* bpf_bar() before offset was widened */
+	__bpf_kfunc int bpf_bar___v1(const struct bpf_dynptr *p, u32 offset);
+
+``resolve_btfids`` rejects it::
+
+	ERROR: resolve_btfids: kfuncs bpf_bar and bpf_bar___v1 have compatible prototypes, libbpf cannot tell them apart
+
+Widening keeps the prototype compatible, so it is done in place instead: drop
+``bpf_bar___v1``, and programs built against the old prototype bind
+``bpf_bar``.
+
+Give the new prototype a new name that doesn't start with ``<name>___`` if
+programs loaded by older libbpf or light skeletons must keep working, or if the
+prototypes are compatible but the change breaks callers, e.g. two integer
+parameters swap places.
+
+Don't rename a ``<name>___vN`` kfunc in place: BPF programs may call it by that
+name. To give its prototype to ``<name>``, keep it as an alias for a
+deprecation period.
+
 4. Core kfuncs
 ==============
 
-- 
2.56.1

