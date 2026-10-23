Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797665;
	b=rn0sDN87paCs7dDFREn/YdtjpVlbwRZrZrqqZlMUc+hl3aGY86WErwJ04zH4Yjo8uZtO
	 H7hmoN4CoMXBh2zNbP+GGH9rjOcWGNohnV9rq0Ec6eaLcFZjEJqCmz09DQbjMJ0k43cMQ
	 ShvKMV2H4HkXNTje7lpze6KiYMuBBNSc5GHpaAwzljzxmISv9Rx0NHYdgWFzGO5Uyd+Qa
	 vF6Kewinz4s4fYF/8BW0XagoYwpbRAXfYjNmwKDmUUZZYTaTlaSPP0YjkeC6ijXPl+nh4
	 Qwx7WP0csB0lSpSTrZmbPUMiiWqGBP9SptFQgjZuK5n2DFIHQhczkkOmHAlCrpBgWjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XYnv7YfbhFAjRnC/fEiU+VSMEEIracvu2g0C3EYDtHw=;
	b=X9IRiJjjo0Io1QwOHiW0riOeHDTW7i0nW8pWJKF0+EzzLqUs/nbFUcy5MDjMelm3wzwV
	 NpOfStb1vgOP/PQkdYa4Q3X/IMJq5GAOZN+6F1PRlXZ4No+X9ej5gRXuLZ7iQkvXzxGQC
	 HeoYQxPCArVpnLnKAgW6AeAo+D5YlSvILHmOzqj+OqefJKPxfCe1sEgpVO0uCXUJHOlqR
	 yI0C9AFB0HGZUtTp/mj3QrqgPyNppCW9SRQDxC4Go8OszGTgRUVo73LN4Vtfl9rUJYgAz
	 gx4f8SxUD7N2Sq0E2UTne8rRbYwRZ5xGlIBjpLt1xu3kkP0ATRs/dmQMsVDEzHmChKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOUDlrza;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D5606A325;
	Fri, 23 Oct 2026 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOUDlrza
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4BC1F01828;
	Fri, 23 Oct 2026 23:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792797664;
	bh=XYnv7YfbhFAjRnC/fEiU+VSMEEIracvu2g0C3EYDtHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EOUDlrzaYeyLjjuOx93KsTeryGvdlnVwYAy+clNdrHCor/sSR1kOGiALmHYG0mxSJ
	 0GnhMEWGKw4Oc8swgqj2hTXlqR7q9a2+75NjmOiy7oE4s6BHTqi3M7n0rLV3m8YSIc
	 5CQKocPLgWWeK8OXdAHnsCtHU/xbIFVH7nXaf705YAWCIqJy0nIKK1XiKI43QUDCWA
	 FeeYOuhucfwef0eljpRo84e5Mmvrb2iXwvgpEGWonnBpdA30T21dDIbiuY/o4efp1N
	 l/jBFQhesPNVEniJeP8VQWINLtMT2VuZ+3M9zmXHvTz9+YvgaU2bA8VFtuFrF20rhl
	 q1gibWmqP+I/Q==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] sched_ext: Don't sign-extend unsigned enums in __COMPAT_read_enum()
Date: Fri, 23 Oct 2026 13:20:59 -1000
Message-ID: <20261023232102.1124938-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023232102.1124938-1-tj@kernel.org>
References: <20261023232102.1124938-1-tj@kernel.org>
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

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 07fb55e63c57..c8d7280ceffa 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -143,7 +143,11 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
 				if (t->size == 8 && !strncmp(type, "scx_", 4))
 					return __COMPAT_recover_truncated_enum64(type, name,
 										 (u32)e[i].val, v);
-				*v = e[i].val;
+				/* kflag marks a signed enum */
+				if (btf_kflag(t))
+					*v = (s64)e[i].val;
+				else
+					*v = (u32)e[i].val;
 				return true;
 			}
 		}
-- 
2.56.0

