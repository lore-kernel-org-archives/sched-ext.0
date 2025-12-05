Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CB2EC0B8
	for <sched-ext@lists.linux.dev>; Fri,  5 Dec 2025 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969826; cv=none; b=lLVUEKDNAwcLinqNnRef5Z7HgQ/4KvE7KYwkP+iq8A4BTJ0y7rbZQoBZdFxU2eYtaZtJjKItYiY12eJCuWWAhemHcDNbOj/lKkcVCpPfFekGm/tw68p6auay3DUlq++lkruxGByKMgyw1y0NI2jxVrnNMN+xU4f97IOtaYRBlyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969826; c=relaxed/simple;
	bh=X58/TLNxNUuyEk0XeKNYJo3ANtRHdl1avjvIB5++HEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XAYh1xfXNIlVwwpETmns9zEt1xIfa8d3D8GQ73Q+ZkwaXBMVOxYkZEWD7SjsVPMCtkskyWelA0AYgWgWUyjn52olUz8LZ5cpUI7cHG03pvnoT3eRvM47QyHyYDvCYwAqYW87w3oQS3swkslNCejokM/3g0v/mKD9njlzz7plYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JcOUT8W2; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JcOUT8W2"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5JSluJ2632162
	for <sched-ext@lists.linux.dev>; Fri, 5 Dec 2025 13:23:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=dChjtNxuWIJ+M9tnz8
	Oc4UcVmRJWkVqTJ8Ohqws93bw=; b=JcOUT8W2O+O3oUmMs6FBE3vUonJX9VigED
	ryKLX4MEKEWLpeG1UISO0QkFCrZMXKJr/N+MWcYewIxNgxVPRjHmOy/EsxezUfUE
	dc4Xe2Qfv7jkc28UuowYYE4NhrzHQ1B+jnELUNFrJR3Rg9B7I6y5JBo89a5r3b/m
	9jX32buF94SIHc6V54+K3ty8uB88on8eiH/GvVekoLqREMpBAFevp4uBIY1ksmux
	rDnzhVVT62+kGvsvyw3NB1FuAoyewWvxP3e+pkpEMskALMNiaJb+mFRlbSt3/0L2
	ncVo8QGa2cRFtSs2Ke/glMd1+eHpgeSbF39rkAYel2cxEW0BF+gA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4av5k8rtun-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Fri, 05 Dec 2025 13:23:43 -0800 (PST)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 5 Dec 2025 21:23:42 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 83ECCD1D3B92; Fri,  5 Dec 2025 13:23:27 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <sched-ext@lists.linux.dev>
CC: <tj@kernel.org>, <arighi@nvidia.com>, <changwoo@igalia.com>,
        <void@manifault.com>, Emil Tsalapatis <etsal@meta.com>,
        Ihor Solodrai
	<ihor.solodrai@linux.dev>,
        Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH] selftests/sched_ext: flush stdout before test to avoid log spam
Date: Fri, 5 Dec 2025 13:23:14 -0800
Message-ID: <20251205212314.3553009-1-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bokGEnEfzbKqyh74vV6f9ArfF0zGRUrW
X-Authority-Analysis: v=2.4 cv=PsuergM3 c=1 sm=1 tr=0 ts=69334d5f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=5nxjlEnvi7Txu-jdf70A:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDE2MCBTYWx0ZWRfXwt07afv6y5B8
 QfSez/02UtpeD44z3TmwlWiV09jS0HY51njU+zFZp5+ogRj7N4+yalA+y8oe8288CEsn9Z2xp4s
 DrTli1GySJR5QaqMp/x8k2dVGdoq7pazMAMJgXgziTEKRKTzcH1cuQN5XMUOD4gKoSfc30soJsw
 CylD9iC7U1QcDLHr7rkSTaPUNed5pSBUj4FKqQHg42ulZDKxrQd+CAgZUuVlvRYwDUF9ucvnEGC
 EO8Atee5xPGLG9VgPXk9HsYg2ZB5tM8BTW2WLXPcf5GOXTwsjpIA4Pb0pNxF91lHRtCFSwg/Mdr
 Ao3oCkSAJTh4jk8jFK6PP8br407Evbj6hnWcxJviezhmK6IMzIo7k+oZ6vMTQwGMG8kj7HQ8XhL
 WGOxTKrtIgHdpszQrmtUSWB7s52nzw==
X-Proofpoint-ORIG-GUID: bokGEnEfzbKqyh74vV6f9ArfF0zGRUrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_08,2025-12-04_04,2025-10-01_01

The sched_ext selftests runner runs each test in the same process,
with each test possibly forking multiple times. When the main runner
has not flushed its stdout, the children inherit the buffered output
for previous tests and emit it during exit. This causes log spam.

Make sure stdout/stderr is fully flushed before each test.

Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/sched_ext/runner.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/s=
elftests/sched_ext/runner.c
index aa2d7d32dda9..5748d2c69903 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -46,6 +46,14 @@ static void print_test_preamble(const struct scx_test =
*test, bool quiet)
 	if (!quiet)
 		printf("DESCRIPTION: %s\n", test->description);
 	printf("OUTPUT:\n");
+
+	/*
+	 * The tests may fork with the preamble buffered
+	 * in the children's stdout. Flush before the test
+	 * to avoid printing the message multiple times.
+	 */
+	fflush(stdout);
+	fflush(stderr);
 }
=20
 static const char *status_to_result(enum scx_test_status status)
--=20
2.47.3

