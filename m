Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036021;
	b=YY0cBOTZDOHqSvEF73aX/OyFH8Lmrg9eNU9kvc+aeglJ1lRh9EWKCww8vEgeH1eRj0tn
	 6RRE7B6sWMoHfkMEoDhCppQwfJIkFpf2VYfSXcamuF3/0vPi2cHNEcRO0cY2649ezNMpL
	 KtcyIXge22yjqtAPIPHfuendLQBy6eAEGdLaovAX1GL9h62ErvWRL/4bdj30tkdB9dPoi
	 7Gp7T2v6h4MS/YRZOqW440YEkKent4yiZx+aJhj6zZdFZpfQ5FyYgWypcoIBXHxXD49ka
	 O/iE9Lczavrxf9aDb9UZu8rjkEbHa3N6kQSrxE4t1PIZ/h5zCcQNRK6EwjKPq+QqEZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SXsqzoFNedK5GT1shEs1eQ24eoNySIwst4DZBbCDUO8=;
	b=nSd0ZHtn/3q7u4AotZ7Bd+F3M3XUvbVm2YtbFr5REw8qBjmMdPzaCtVYeoZCVI1rpNQ3
	 mJB+tN6YBaWKxvcsQvB+j07Otj8HCD5DE3Y2ifl6qCFuC8qHmjhfQKls26JcPnAhNy5L9
	 OaWsSc0BnR5Z0BqyZz0eagGe/na+9ks3FUVt22TfeQtXwmHTIGOExeYW8zE4oRHQ0fajY
	 CrmrdGwnUALSZSBfsrowhCiFOcBi40EDgCtGB1U8XCTHAaQFv3sVJsQPmsSMb/g6rIKeJ
	 TRfO5Fln2ZqOj4ibnRboqpYK+/RPLVAPH2QR64P76iIvMmtpi+MDfDQWdLhq59rBZHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVBxyOB3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA1606A31D;
	Mon, 26 Oct 2026 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVBxyOB3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A011F01825;
	Mon, 26 Oct 2026 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036020;
	bh=SXsqzoFNedK5GT1shEs1eQ24eoNySIwst4DZBbCDUO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lVBxyOB3iIJGyZH4wmlC3WW+1P5J2do+e4zkT5CK8SclBjB5ja6r0ScmMUFPRhAty
	 7VKcIMP0mnh/tELbv2tM0UZQFMPV/DFzCeNefHOX8pkawaLCS418kCOpZ18HE6Ud8o
	 g0rhfPt7J5+OtByFAJV4ItGX95a0tHkB209PutVhVFpyvwWwKeiduL0Fu/y0m6WbkP
	 WgX4grmnqiZ7yuNjp/JKHMvg2ICu1BDGcPDXnqGcCVZTGolPPoaqyIu2KoKu+xYQ/l
	 I7KVG3wqP3ZcdLSh+RszExNu2B7T8wCOefkmPFZVeT3anvdsPnIeS5uzXxSrmtzAPT
	 zrE23m+culeqw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 1/4] sched_ext: Don't sign-extend unsigned enums in __COMPAT_read_enum()
Date: Mon, 26 Oct 2026 07:33:39 -1000
Message-ID: <20261026173339.584908-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023232102.1124938-2-tj@kernel.org>
References: <20261023232102.1124938-2-tj@kernel.org>
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

__COMPAT_read_enum() looks an enumerator up in the running kernel's BTF. For
a 4-byte enum, it assigns struct btf_enum.val, an __s32, to the u64 result,
which sign-extends. BTF records the enum's signedness in the type's kflag.
The code ignores it, so an unsigned enumerator with bit 31 set is
sign-extended too.

b1c2a6b0d90d ("sched_ext: scx_qmap: Read SCX_RESCUE_DISABLE through the enum
lookup tables") added SCX_RESCUE_DISABLE to the enum lookup tables. It is
U32_MAX in enum scx_consts and the only such enumerator in the tables. BPF
code sees it as 0xffffffffffffffff instead of 0xffffffff, so a comparison
against a u32 holding the real value never matches.

scx_qmap, its only user, narrows the value to u32 in userspace and is
unaffected.

Sign-extend only when the kflag says the enum is signed and zero-extend
otherwise. A signed enum keeps the sign extension, which is what C gives
when the enumerator converts to u64. SCX_TASK_CURSOR, 1 << 31 in a signed
enum, still reads 0xffffffff80000000. Verified with a probe against a built
kernel's BTF.

v2: Note in the comment that pahole < 1.24 never sets the kflag (Andrea).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
Applied to sched_ext/for-7.5.

 tools/sched_ext/include/scx/compat.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 07fb55e63c57..8a17854cc626 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -143,7 +143,15 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
 				if (t->size == 8 && !strncmp(type, "scx_", 4))
 					return __COMPAT_recover_truncated_enum64(type, name,
 										 (u32)e[i].val, v);
-				*v = e[i].val;
+				/*
+				 * kflag marks a signed enum. BTF generated by
+				 * pahole < 1.24 never sets it, so signed enums
+				 * are zero-extended there too.
+				 */
+				if (btf_kflag(t))
+					*v = (s64)e[i].val;
+				else
+					*v = (u32)e[i].val;
 				return true;
 			}
 		}
-- 
2.56.0

