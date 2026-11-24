Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560529;
	b=x7N6dz0CXx1Z8XX0MNVUUnd6+/kWR4XTAFFsC4v//JUPeumUIH7yJtrWl4h4fexR68m5
	 Yv0CmA7tKyjyWw8pQ3H5C3QUvxjFtqDBZ4uY9am7zeUJ49q+iAeiBH4cqxbBd/gKZ9gyk
	 ZUT3HEVwSYQ75Gko2tMTKPH/1X8PoohCbx09wpwuMnt+Bx6rc+NRHI4NKHRg1ir0bEP5/
	 fqzZFTBStQ+SdOahPiZ3qnASbYbQDX53vG1FHArOglxIFBmSJc6jMQaBIk8Fsne/W/T9D
	 J52yD1SZiD0jnTTzpaswhfogFxcpMHyESyhDJByH8sZk51ij5vse0lJ7nSgO4pmZx+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560529;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mWnH3KwWgrqBhOLVLwR1FQPdX8lFVp3mEV3Ku0UuUhw=;
	b=HfTLBcFB2iklBbYiafqZoqanNc+CJWGgonqi+J0YihN1SqJlM8Rveuwk5VkAgeMQVwXC
	 tsuGt9vnFxM3Jv+dUYF5JgCvTt9mr5Wg8F+B4Iw2fEY897rEIRMaReCj2yEFN1jyhDwvL
	 3oG+oV3ZjOoaJaVe7+PjHydqNWrMijSAG1kj72x0WYciDcmphA6jJohsjGONi1UP62iVu
	 yc5vKNs1DjOldDbq6Srwt/KYg9B/FXS1E8QoDsD1PMgCehVtscFNbTrFpR8JD2hjze4rA
	 fsnJDdcGL4MlhhY1nEZ60HLAB8pyhjQIOiZ+ojkOxNINYHxMqpXwkDYOGx/O8agb6zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MJAlAeXR;
	arc=none smtp.remote-ip=95.215.58.86
Received: from mta1.migadu.com (out-86.mta1.migadu.com [95.215.58.86])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C290606A329
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 22:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C290606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MJAlAeXR
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=EcqbZB1OxH0qu5490o9LdjMRCZshiMRYEZO7x3iyBtw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795560526; v=1; x=1796165326;
 b=MJAlAeXRC3icCHtwqzspF7eXR56XBUsedL73wpkFhXF9IHaL2UMYjMSHaclaBDWsJ6hVeamP
 ILjOCUhjYfhCaB3SPC3MMuk2/B9kI84/pfzwLRc+Y2JzHdIEE/KuMwnkUdwxdtxHerx2XcZcSMe
 tErq6+O1zLle4sZ00/tBar4w=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 6b2124b402350240;
	Tue, 24 Nov 2026 22:48:45 +0000
X-Mizu-Trace-ID: 6b2124b402350240
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
Subject: [PATCH bpf-next v3 6/6] docs/bpf: Describe how to change a kfunc's prototype
Date: Tue, 24 Nov 2026 15:48:11 -0700
Message-ID: <20261124224811.16134-7-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124224811.16134-1-ihor.solodrai@linux.dev>
References: <20261124224811.16134-1-ihor.solodrai@linux.dev>
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
expectations. libbpf now binds a ___-suffixed kfunc by prototype and
resolve_btfids rejects kfuncs that libbpf can't tell apart, so kernel
developers can keep BPF programs built against an old prototype loading,
provided they follow the rules this section describes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 335dbb833bfe..caaa69731339 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -800,6 +800,105 @@ procedure is followed for removal:
 3. After the deprecation period the kfunc will be removed. At this point, BPF
    programs calling the kfunc will be rejected by the verifier.
 
+3.2 Changing a kfunc's prototype
+--------------------------------
+
+libbpf drops the last ``___suffix`` from the name of a kfunc declared in a BPF
+program and from the names of functions in kernel and module BTF, as it does
+for CO-RE type names. Among the functions with the same remaining name, it
+binds the one with a prototype that matches the declaration. Types are
+compared kind by kind, and structs and unions by name only:
+
+.. code-block:: c
+
+	typedef struct task_struct task_t;
+
+	/* these match */
+	int bpf_foo(struct task_struct *p, u32 flags);
+	int bpf_foo(const task_t *p, u64 flags);
+	int bpf_foo(struct task_struct___local *p, int flags);
+
+	/* none of these match the ones above */
+	int bpf_foo(struct file *p, u32 flags);
+	int bpf_foo(struct task_struct *p);
+	void bpf_foo(struct task_struct *p, u32 flags);
+
+If the old and new prototypes match, change the kfunc in place. Otherwise the
+new prototype keeps the name, and the old one stays available as
+``<name>___v1`` (``___v2`` for the next change, and so on) for a deprecation
+period, usually as a thin wrapper registered with the same flags:
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
+	/* the suffix doesn't select a kfunc: both bind bpf_foo___v1 */
+	extern int bpf_foo___v1(struct task_struct *p) __ksym;
+	extern int bpf_foo___local(struct task_struct *p) __ksym;
+
+	/* a stacked suffix binds nothing */
+	extern int bpf_foo___v1___local(struct task_struct *p) __ksym;
+
+Only libbpf 1.9 and later look for ``bpf_foo___v1`` when resolving ``bpf_foo``.
+Older libbpf and light skeletons see only ``bpf_foo``, as after an in-place
+change.
+
+If two kfunc names differ only in the ``___`` suffix, their prototypes must not
+match, not even for aliases: libbpf can't tell them apart and fails to load a
+program that declares either one, even as ``__weak``. For example, this widens
+an offset to 64 bits and keeps the old prototype as ``bpf_bar___v1``:
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
+	ERROR: resolve_btfids: kfuncs bpf_bar and bpf_bar___v1 have matching prototypes
+
+Widening keeps the prototype matching, so it is done in place instead: drop
+``bpf_bar___v1``, and programs built against the old prototype bind
+``bpf_bar``. ``resolve_btfids`` checks registered kfuncs within vmlinux or one
+module. libbpf catches other matches, such as between two modules, when loading
+the program.
+
+Give the new prototype a name outside the family, not ``<name>___*``, if:
+
+- programs loaded by older libbpf or light skeletons must keep working, or
+- the prototypes match but the change breaks callers, e.g. two integer
+  parameters swap places.
+
+Older libbpf resolves ``bpf_foo___v1`` only from a declaration with a stacked
+suffix, such as ``bpf_foo___v1___compat``, and light skeletons only from
+``bpf_foo___v1`` itself. Don't rename a ``<name>___vN`` kfunc while programs
+declaring it that way are in use. libbpf 1.9 and later bind by prototype, so a
+rename doesn't affect them.
+
 4. Core kfuncs
 ==============
 
-- 
2.56.0

