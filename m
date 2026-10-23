Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713832;
	b=iil/RnKDHpf2u8CvwSJuj28ARBrJ6kGGZwu8/jsrdLalfay9x9ZTa9wLrbGuKMNCulIX
	 vYMo/yDv7KbQnC/xesut9BsOuyl25RYmW0x2h50/DE9zIElpljx5o9vynnPMOjSRq473/
	 R6ns2o6VMxO4fQm9HPMaDEhjkT3mhwbXKryu133TDRf6pGr1N+UhV7CshEyvynAUYcdNx
	 xBdzAuyZkUhgXF4CoODumftCJuxasaMu9nsE30TNXZWmeY5sN8KumNXTI+Ss66wUB8ATP
	 sVH4L6NNqucOI7PLUELi6raKlNqRDxQ77of8BlxVu+D60GxaMJgO6GM/q+rruosPEIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vXVJUgYfOihfbqdTY/uv8+U1ayywzPla3iXUVWTuYSs=;
	b=wp0XCSs4fUrdPwH7kEWYo2uVaSqwSQ8rhmONHS4lp2QKjEfEhHDiUKOr9ZjG2dtMspHu
	 w1zq99YoWtGuZZXdDE/ixymxjf2G/H5wLBpqQ+j1wctPlQXDsQtS7RAsAf9CuHM67wWka
	 L2746L0WQFDJxQpT+UjLFupgQv3JStTbhb4GXf5r08vEWLtUpUZ7hA0PECoIB5d/TLrKz
	 pCpQyao0oQ0fK6OjEKbnxyjl7F7TkibwYgEja7T85sSES+7lZYEzsbHXeRyKWzWr8CeM6
	 9uSzuCUvrsxzNitfdvzPvvjFCxfpgyp/lCWJRURVpJH2Uk3LDvD3exaQAELDZwXY+tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U+J4ICA/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3FF606A31A;
	Fri, 23 Oct 2026 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+J4ICA/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440941F01825;
	Fri, 23 Oct 2026 00:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792713831;
	bh=vXVJUgYfOihfbqdTY/uv8+U1ayywzPla3iXUVWTuYSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U+J4ICA/r7kOeEs3BkaIP2mEgTnt3fbZ37Tx5z+o9Py/c9kzpwHN7jWJhm7irPu79
	 hECEVfDzlviJebpiFTIl1fT3J0vgLkVtuafYKXNfCqOG9bM1brWdlzGPM+4T2ujSjX
	 aSMhQhFKtl4o7rKtfggxzrSG8guubTV10QUQzlHd0HMseyv1eeMtCPjPwsKLwB1vOL
	 C+YdL4nHC+t5hgAd+SrGJ9qpnkmEKBVJpLLEXqdDLyqmVYLwhvNT53OvS/aHfIe7LJ
	 hYDgt2Pa60PUTSm4lecQ60Mu0ddiAcqzI6Q2ChO4ExUCEN16dOMKLq7+zhHVkyzESd
	 c4vVVZimqAeQA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: scx_qmap: Read SCX_RESCUE_DISABLE through the enum lookup tables
Date: Thu, 22 Oct 2026 14:03:48 -1000
Message-ID: <20261023000348.2726436-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023000348.2726436-1-tj@kernel.org>
References: <20261023000348.2726436-1-tj@kernel.org>
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

788b494fab1c ("sched_ext: scx_qmap: Drop the compat code") left one compat
lookup behind: the -B 0 case reads SCX_RESCUE_DISABLE with
__COMPAT_ENUM_OR_ZERO(). Userspace can read SCX_RESCUE_DISABLE only from BTF
as it is in the kernel-internal enum scx_consts. The enum lookup tables
already read their entries from BTF for every scheduler at open time.

Add SCX_RESCUE_DISABLE to the lookup tables and read it from the skeleton's
rodata. No behavior change.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/all/ataTuzRFTRm_pax6@gpd4/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/enums.autogen.bpf.h | 3 +++
 tools/sched_ext/include/scx/enums.autogen.h     | 1 +
 tools/sched_ext/scx_qmap.c                      | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 405a3e6b8f33..d0c37018659e 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -13,6 +13,9 @@ const volatile u64 __SCX_SLICE_DFL __weak;
 const volatile u64 __SCX_SLICE_INF __weak;
 #define SCX_SLICE_INF __SCX_SLICE_INF
 
+const volatile u64 __SCX_RESCUE_DISABLE __weak;
+#define SCX_RESCUE_DISABLE __SCX_RESCUE_DISABLE
+
 const volatile u64 __SCX_RQ_ONLINE __weak;
 #define SCX_RQ_ONLINE __SCX_RQ_ONLINE
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index 7ec2e5e41cb2..c4a7260f0983 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -9,6 +9,7 @@
 	SCX_ENUM_SET(skel, scx_public_consts, SCX_OPS_NAME_LEN); \
 	SCX_ENUM_SET(skel, scx_public_consts, SCX_SLICE_DFL); \
 	SCX_ENUM_SET(skel, scx_public_consts, SCX_SLICE_INF); \
+	SCX_ENUM_SET(skel, scx_consts, SCX_RESCUE_DISABLE); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_ONLINE); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_CAN_STOP_TICK); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BAL_PENDING); \
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 9b1cbe187ebd..fe2f206f5c8a 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -427,7 +427,7 @@ int main(int argc, char **argv)
 			u32 ppt = strtoul(optarg, NULL, 0);
 
 			if (!ppt)
-				ppt = __COMPAT_ENUM_OR_ZERO("scx_consts", "SCX_RESCUE_DISABLE");
+				ppt = skel->rodata->__SCX_RESCUE_DISABLE;
 			skel->struct_ops.qmap_ops->rescue_bandwidth_ppt = ppt;
 			break;
 		}
-- 
2.56.0

