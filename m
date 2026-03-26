Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DC3A2573;
	Thu, 26 Mar 2026 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556035; cv=none; b=f3DFYHNqebTOrrjGjBVb/EJMQioi6ghmt1986aQu7ibptNfjFDKaVHpASPodgeX64J6LsD5tJKtPOrLpd2E+uf+2oOaevRkvbZoEJV4j0dFWkWKAebtP+9UtMHR8Yf8+1DOSqN+KAeQnBXwJ9PdxIvioMIjqqH/JQTTEaJ+B4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556035; c=relaxed/simple;
	bh=7P1JT6n95hfyEoI20is1ulnbrUMBuU9ZrIIcxuKI/3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns3ziV0V+y2tXSb06fBSmp2kcj7ld3nzgDMjFevEqwwB38Nv1jDlYDJ72xdYHkYar0FOWZHnUEUoAe7HXP6XToCAC8iR58K56DNYjUiPq8s3Kp2l3UYTVAbPBLHf+sUtJPsMfT4UreND0P3q7MkSlaNZxKCJkoc9cFglU0LcgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxZT0IN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxZT0IN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629FCC2BC87;
	Thu, 26 Mar 2026 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774556035;
	bh=7P1JT6n95hfyEoI20is1ulnbrUMBuU9ZrIIcxuKI/3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxZT0IN940dbzMC7bAoX8tCAbvVfXFGJpvY51YH2KtkIVIo9zO4mRHsQXR1mqZT5w
	 w178yNVU967mvjJXdGpPwsi0xPlfOAIeUyuexpVcnPfIXmj10UA6uQngRZWO0eCwBj
	 DisXcHr0yFSuy/UXzqlcsD6YuZF0NeX31S+KKsA6P1mcjZOBY1MkFflDTtGNhcTS96
	 /ZwanAKCxmEh8sIlkUKB6PlKIjVOCh2c8sdGyqxp5bL1ZClXtANZmZTUMlpgPEUtUa
	 7Did0WXqlL5+fgIevDo/mtXVSIQcNhHbzzYSGUQzbxDwb3Y65Q6TT/IH6c4hfhcPkX
	 5RckdRYQY6o4A==
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	zhaomengmeng@kylinos.cn,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.1] tools/sched_ext: Remove redundant SCX_ENQ_IMMED compat definition
Date: Thu, 26 Mar 2026 10:13:54 -1000
Message-ID: <20260326201354.2837750-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326100313.338388-1-zhaomzhao@126.com>
References: <20260326100313.338388-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compat.bpf.h defined a fallback SCX_ENQ_IMMED macro using
__COMPAT_ENUM_OR_ZERO(). After 6bf36c68b0a2 ("tools/sched_ext:
Regenerate autogen enum headers") added SCX_ENQ_IMMED to the autogen
headers, including both triggers -Wmacro-redefined warnings.

The autogen definition through const volatile __weak already resolves to
0 on older kernels, providing the same backward compatibility. Remove
the now-redundant compat fallback.

Fixes: 6bf36c68b0a2 ("tools/sched_ext: Regenerate autogen enum headers")
Link: https://lore.kernel.org/r/20260326100313.338388-1-zhaomzhao@126.com
Reported-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.bpf.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 654b566bd94a..8977b5a2caa1 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -422,11 +422,6 @@ static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
 		scx_bpf_error("kernel too old to reenqueue foreign local or user DSQs");
 }
 
-/*
- * v7.1: %SCX_ENQ_IMMED.
- */
-#define SCX_ENQ_IMMED	__COMPAT_ENUM_OR_ZERO(enum scx_enq_flags, SCX_ENQ_IMMED)
-
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.53.0

